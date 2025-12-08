# 🛒 Group8_ShopZada
Github repository for Group 8's ShopZada Data Warehouse

## 🗃️ Directory 
```
group8_shopzada/
├── docker-compose.yml                        # ← Provided in infra/
├── airflow/                                  # 
│   └── Dockerfile                            # ← Provided in infra/airflow/ 
├── data/                                     # ← Dataset of Shopzada containing the different departments
│   └── Business Department                   #
│   └── Customer Management Department        #
│   └── Enterprise Department                 #
│   └── Marketing Department                  #
│   └── Operations Department                 #
├── dags/                                     #
│   └── etl_pipeline.py                       # ← Provided in workflows/
├── python-ingestion/                         # 
│   └── ingest.py                             # ← Provided in scripts/ingestion/
├── r-transformation/                         #
│   └── cleaning.R                            # ← Provided in scripts/data_cleaning/
├── sql/                                      #
│   ├── merge.sql                             # ← Provided in sql/
│   └── create_facts.sql                      # ← Provided in sql/
│   └── create_dims.sql                       # ← Provided in sql/
```

## ⚙️ Set-up Guide
1) Ensure the following project structure exists above
2) Build the docker image
```
docker-compose build 
```
3) Run the webserver
```
docker-compose up -d
```
4) Access the Airflow UI
```
Access: http:localhost//localhost:8080
Username: admin
Password: admin
```
5) Trigger the DAG.
6) 
