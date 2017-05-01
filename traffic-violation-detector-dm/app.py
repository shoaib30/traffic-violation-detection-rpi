import requests

body ={
    'username': 'traffic-node',
    'password': 'password'
}
response = requests.post('http://localhost:5000/api/node/posts',data=body)

print response.text