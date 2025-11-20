"""
============================================
Draft: Ingest Script
============================================
Script Purpose:
    This is a draft ingest script that given a folder or file of data
    will ingest it into PostgreSql with same table name as the file name,
    drops table if already exists.
============================================
"""

import pandas as pd
from sqlalchemy import create_engine
import argparse
import os
from pathlib import Path

def main():
    # Parse command line arguments
    parser = argparse.ArgumentParser(description='Simple Data Ingestion Pipeline')
    parser.add_argument('--user', default='root', help='Database username (default: root)')
    parser.add_argument('--password', default='root', help='Database password (default: root)')
    parser.add_argument('--host', default='localhost', help='Database host (default: localhost)')
    parser.add_argument('--port', default='5432', help='Database port (default: 5432)')
    parser.add_argument('--db', required=True, help='Database name')
    parser.add_argument('--data_dir', required=True, help='Directory with data files')
    
    args = parser.parse_args()

    # Connect to database
    engine = create_engine(f'postgresql://{args.user}:{args.password}@{args.host}:{args.port}/{args.db}')

    # Supported file extensions
    supported_extensions = {'.csv', '.parquet', '.pkl', '.pickle', '.xlsx', '.xls', '.json', '.html'}

    # Process each file in the directory
    for file_path in Path(args.data_dir).iterdir():
        if file_path.is_file() and file_path.suffix.lower() in supported_extensions:
            process_file(file_path, engine)

    print("All files processed!")

def process_file(file_path, engine):
    file_name = file_path.stem  # Get filename without extension
    file_ext = file_path.suffix.lower()
    
    print(f"Processing: {file_path.name}")
    
    try:
        # Read file based on extension
        if file_ext == '.parquet':
            df = pd.read_parquet(file_path)
        elif file_ext == '.csv':
            # Try regular CSV first, then tab-separated
            try:
                df = pd.read_csv(file_path)
            except:
                df = pd.read_csv(file_path, sep='\t')
        elif file_ext in ['.xlsx', '.xls']:
            df = pd.read_excel(file_path)
        elif file_ext in ['.pkl', '.pickle']:
            df = pd.read_pickle(file_path)
        elif file_ext == '.json':
            df = pd.read_json(file_path)
        elif file_ext == '.html':
            # Get first table from HTML
            df = pd.read_html(file_path)[0]
        
        # Clean table name
        table_name = file_name.lower().replace('-', '_').replace(' ', '_')
        
        # Load to PostgreSQL
        df.to_sql(name=table_name, con=engine, if_exists='replace', index=False)
        
        print(f"✓ Loaded {len(df)} rows into table '{table_name}'")
        
    except Exception as e:
        print(f"✗ Error processing {file_path.name}: {e}")

if __name__ == "__main__":
    main()

