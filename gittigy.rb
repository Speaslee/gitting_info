require "httparty"
require "pry"
require "json"

 keys = File.read "./auth_key.txt"
 puts "What organization are you looking at?"
  answer = gets.chomp
 org = answer

 response = HTTParty.get "https://api.github.com/orgs/#{org}/members", headers: {
  "Authorization"=> "token #{keys}",
  "User-Agent" => "speaslee"
}
response.each_with_index do |member, i|
  puts "#{i} #{member["login"]}"
  repo_list = HTTParty.get "https://api.github.com/users/#{member["login"]}/repos", headers: {
   "Authorization"=> "token #{keys}",
   "User-Agent" => "speaslee"
  }
  repo_list.each do |repo|
  puts"\t - #{repo["name"]}"
end
end
