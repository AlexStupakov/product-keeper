require 'sinatra'
require 'mongoid'
require 'json'
require 'dotenv/load'

require_relative './models/product'
require_relative './serializers/product_serializer'
require_relative './workers/api_worker'


# DB Setup
Mongoid.load! "configs/mongoid.yml"

get '/add-data' do
  APIWorker.new.store_data File.read('MOCK_DATA.csv')
  'Great! You updated data from local file!'
end

get '/all-the-data' do
  content_type :json
  Product.all.map { |product| ProductSerializer.new(product) }.to_json
end

get '/:producer' do |producer|
  content_type :json
  params[:per_page] ||= 10
  params[:page] ||= 1
  result = {
    page: params[:page].to_i,
    per_page: params[:per_page].to_i,
    total: Product.where(producer: producer).count
  }
  result[:products] = Product
    .where(producer: producer)
    .skip((params[:page].to_i-1)*params[:per_page].to_i)
    .limit(params[:per_page])
    .map { |product| ProductSerializer.new(product) }
  result.to_json
rescue Mongo::Error::OperationFailure
  'Please use correct range'
end

