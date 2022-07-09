from flask import Flask, render_template
import requests
import ast

app = Flask(__name__)

@app.route('/health')
def health():
	return 'OK'

@app.route('/')
def show_me():
    rs = requests.get("https://api.coingecko.com/api/v3/exchange_rates")
    byte_data = rs.content 
    dict_str = byte_data.decode("UTF-8") # converting byte to string
    data = ast.literal_eval(dict_str) # convert string to dict
    rates = data.keys() # rates
    row_headers = list(list(data.values())[0].values())[0].keys() # headings
    return render_template("index.html", rates=rates, row_headers=row_headers, mfp_data=data)

if __name__ == '__main__':
	app.run(debug=False, host='0.0.0.0', port='80')
