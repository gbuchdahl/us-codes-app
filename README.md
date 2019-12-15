# us_codes

A mobile app designed to make the US Codes more accessible. Designed by Max Lukianchikov and Gabriel Buchdahl for CPSC 183 at Yale. 

### Pulling data

A python script hits the US.gov API to load the data into our app.
This only needs to be run one time, but the set-up is as follows:

```
cd scrape
source /venv/bin/activate/
pip install -r requirements.txt
```

Create a file `config.py` that contains the API Key in the format:
`API_KEY = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"`

Then run the script `python scraper.py`. 


