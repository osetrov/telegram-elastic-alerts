require "sinatra"
require 'telegram/bot'
require 'multi_json'

set :port, ENV["PORT"] || 5666

def json_load(request_body)
  request_body.rewind
  body = request_body.read

  MultiJson.load body
end

post '/:token' do |token|
  Telegram::Bot::Client.run(token.to_sym) do |bot|
    if bot
      data = json_load(request.body)

      updates = bot.api.get_updates

      if updates.dig("ok") == true
        chat_ids = updates["result"].map{|update| update.dig("my_chat_member","chat","id")}.compact.uniq
        chat_ids.each do |chat_id|
          bot.api.send_message(chat_id: chat_id, text: "#{data}")
        end
      end

      status 200
    else
      $stderr.puts "WARNING. unexpected/uknown token: #{token}".red
      status 400
    end
  end
end