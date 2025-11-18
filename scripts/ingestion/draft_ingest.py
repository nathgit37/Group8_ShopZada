"""
============================================
Draft: Ingest Script
============================================
Script Purpose:
    This is a draft ingest script that given a folder or file of data
    will ingest it into PostgreSql, drops table if already exists
============================================
"""

import pandas as pd
from sqlalchemy import create_engine
import argparse
import os
import glob

def main():
    parser = argparse.ArgumentParser(description='Simple Data Ingestion')
    parser.add_argument('--user', required=True)
    parser.add_argument('--password', required=True)
    parser.add_argument('--host', required=True)
    parser.add_argument('--port', required=True)
    parser.add_argument('--db', required=True)
    parser.add_argument('--table_name', required=True)
    parser.add_argument('--file_path', required=True)
    
    args = parser.parse_args()

    # Connect to database
    engine = create_engine(f'postgresql://{args.user}:{args.password}@{args.host}:{args.port}/{args.db}')

    # Get files to process
    if os.path.isfile(args.file_path):
        files = [args.file_path]
    else:
        files = glob.glob(os.path.join(args.file_path, '*'))
    
    print(f"Processing {len(files)} file(s)...")

    for file_path in files:
        file_ext = os.path.splitext(file_path)[1].lower()
        file_name = os.path.basename(file_path)
        
        print(f"Reading {file_name}...")
        
        try:
            # Read file based on extension
            if file_ext == '.csv':
                df = pd.read_csv(file_path)
            elif file_ext == '.parquet':
                df = pd.read_parquet(file_path)
            elif file_ext in ['.xlsx', '.xls']:
                df = pd.read_excel(file_path)
            elif file_ext == '.json':
                df = pd.read_json(file_path)
            elif file_ext in ['.pkl', '.pickle']:
                df = pd.read_pickle(file_path)
            else:
                print(f"Skipping unsupported format: {file_ext}")
                continue
            
            # Add source file info
            df['source_file'] = file_name
            
            # Save to database
            if_exists = 'replace' if files.index(file_path) == 0 else 'append'
            df.to_sql(args.table_name, engine, if_exists=if_exists, index=False)
            
            print(f"✓ Successfully loaded {file_name} ({len(df)} rows)")
            
        except Exception as e:
            print(f"✗ Error with {file_name}: {e}")

    print("Data ingestion complete!")

if __name__ == "__main__":
    main()
    
