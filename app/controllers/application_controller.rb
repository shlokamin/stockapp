require 'yahoo_finance'
require 'date'

class ApplicationController < ActionController::Base

	def index
		render :template => "index" 
	end 

	def data 
		values = YahooFinance.quotes([params[:stock]], [:name, :symbol])
		stocks = YahooFinance.historical_quotes(params[:stock], { start_date: Time::now-(24*60*60*30), end_date: Time::now, :period => :daily }) # 30 days
		# Map object to array averaging high low open close
		data = stocks.map do |stock|
			avg = (stock.high.to_f + stock.low.to_f + stock.open.to_f + stock.close.to_f)/4
			date = Time.parse(stock.trade_date)
			point = [[date.day, date.month, date.year], avg.round(2)]
			
		end

		render :template => "data", :locals => {:name => values[0].name, :symbol => values[0].symbol, :data => data.to_json }

	end


end