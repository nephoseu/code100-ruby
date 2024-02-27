require 'net/http'
require 'json'

email = 'ws1-round2a@code100.dev'
password = 'Q56T-987J-L38T'

# uri = URI('https://google.com')
# Net::HTTP.get(uri)

# Step 1: Login
uri = URI('https://challenger.code100.dev/login')
response = Net::HTTP.post(uri, { email: email, password: password }.to_json, {'Content-Type' => 'application/json'})

if response.code != '200'
  puts "Error: #{response.code}"
  puts response.body
  exit
end

token = JSON.parse(response.body)['token']
puts token

# Step 2: Call Authenticated Endpoint
uri = URI('https://challenger.code100.dev/testauthroute')
test_response = Net::HTTP.get(uri, {'Authorization' => "Bearer #{token}"})
puts test_response

# Step 3: Get the puzzle
uri = URI('https://challenger.code100.dev/getpuzzle')
puzzle_response = Net::HTTP.get(uri, {'Authorization' => "Bearer #{token}"})
puts puzzle_response

# Step 4: Solve the puzzle

############################
###### YOUR CODE HERE ######
############################

answer = { answer: 'Your Answer in required format' }.to_json

# Step 5: Submit the solution, timeout set to 60 seconds
uri = URI('https://challenger.code100.dev/postanswer')
solution_response = Net::HTTP.post(uri, answer, {'Content-Type' => 'application/json', 'Authorization' => "Bearer #{token}"})
puts solution_response.body



