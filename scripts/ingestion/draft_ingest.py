"""
============================================
Ingestion Script
============================================
Script Purpose:
    This is a draft ingest script that given a folder or file of data
    will ingest it into PostgreSql with same table name as the file name,
    drops table if already exists. Edited to address csv files that are 
    separated by '\t".
============================================
"""

import pandas as pd
from sqlalchemy import create_engine
import argparse
import os
from pathlib import Path

def ingest_data():
    # Parse Arguments to connect to database similar to FA4
    parser = argparse.ArgumentParser(description='Data Ingestion Script')
    parser.add_argument('--user', default='root', help='Database username (default: root)')
    parser.add_argument('--password', default='root', help='Database password (default: root)')
    parser.add_argument('--host', default='localhost', help='Database host (default: localhost)')
    parser.add_argument('--port', default='5432', help='Database port (default: 5432)')
    parser.add_argument('--db', required=True, help='Database name')
    parser.add_argument('--data_dir', required=True, help='Directory with data files')
    
    args = parser.parse_args()

    # Connect to PostgreSQL database
    engine = create_engine(f'postgresql://{args.user}:{args.password}@{args.host}:{args.port}/{args.db}')

    # File Extensions based on Dataset given
    supported_extensions = ['.csv', '.parquet', '.pkl', '.pickle', '.xlsx', '.xls', '.json', '.html']

    # Checking if each file can be supported based on our supported extensions
    for file_path in Path(args.data_dir).iterdir():
        if file_path.is_file() and file_path.suffix.lower() in supported_extensions:
            process_file(file_path, engine)

    print("All files processed!")

def process_file(file_path, engine):
    file_name = file_path.stem  # Gets the filename
    file_ext = file_path.suffix.lower() #Gets the extension
    
    print(f"Processing: {file_path.name}")
    
    try:
        # Reads the file based on extension
        if file_ext == '.parquet':
            df = pd.read_parquet(file_path)
        elif file_ext == '.csv':
            df = read_csv_file(file_path)
        elif file_ext in ['.xlsx', '.xls']:
            df = pd.read_excel(file_path)
        elif file_ext in ['.pkl', '.pickle']:
            df = pd.read_pickle(file_path)
        elif file_ext == '.json':
            df = pd.read_json(file_path)
        elif file_ext == '.html':
            # Get first table from HTML
            df = pd.read_html(file_path)[0]
        
        # Cleans the table name
        table_name = file_name.lower().replace('-', '_').replace(' ', '_')
        
        # Loads to PostgreSQL
        df.to_sql(name=table_name, con=engine, if_exists='replace', index=False)
        
        print(f"✓ Loaded {len(df)} rows into table '{table_name}'")
        
    except Exception as e:
        print(f"✗ Error processing {file_path.name}: {e}")

#Function to address csv file with different separator
def read_csv_file(file_path):
    """Read CSV file with automatic separator detection"""
    # Try different separators
    separators = [',', '\t', ';', '|']
    
    for sep in separators:
        try:
            df = pd.read_csv(file_path, sep=sep, engine='python')
            # If read with multiple columns, use this separator
            if len(df.columns) > 1:
                print(f"  Detected separator: {repr(sep)}")
                return df
        except:
            continue

#Automatically runs the function when script is called
ingest_data()

