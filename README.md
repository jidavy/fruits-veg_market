# Fruits And Veg App
![screenshot of app](2tierDeployment.png)

A simple app to show how a 2 Tier app works. A list of **fruits** and **vegetables**

- **HTML + JS** frontend (Tier 1) - fetches data
- **FastAPI/Python** - backend  (Tier 2) provides `/fruits`

## Note

- The frontend points to python backend on `localhost:9000`. You might need to update this

## Frontend Requirments
 - Install Nginx/HTTPD and deploy index.html file as required
 - Install git to download repo

##  Python Requirments
 - Install git to download repo
 - ensure you python 3 on the server
 -  git clone https://github.com/techbleat/fruits-veg_market.git
 -  cd ~/fruits-veg_market/python
 - Setup required scripts `python3 -m venv .venv`  
 - activate the script `source .venv/bin/activate`
 - install libraries `python -m pip install -r requirements.txt`
 - run app `uvicorn main:app --host 0.0.0.0 --port 9000 \&`


##  Java Requirments

 - `sudo yum install java-17-amazon-corretto -y`
 - `sudo yum install maven -y`
 - `cd ~/fruits-veg_market/java`
 - `mvn spring-boot:run -Dspring-boot.run.arguments="--server.address=0.0.0.0 --server.port=8080" &`

 
