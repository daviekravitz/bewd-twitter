class TweetsController < ApplicationController
	def index
		@tweets = Tweet.order(id: :desc).all
		render '/tweets/index', :handlers => [:jbuilder]
	end

	def index_by_user
		token = cookies.signed[:twitter_session_token]
		session = Session.find_by(token: token)
		@tweets = User.find_by(username: params[:username]).tweets
		render '/tweets/index', :handlers => [:jbuilder]
	end

	def create
		token = cookies.signed[:twitter_session_token]
		session = Session.find_by(token: token)

		if session
			user = session.user
			@tweet = user.tweets.new(tweet_params)

			if @tweet.save
				render json: {
					tweet: {
						username: user.username,
						message: @tweet.message
					}
				}
			else
				render json: { success: false }
			end
		else
			render json: { success: false }
		end
	end

	def destroy
		token = cookies.signed[:twitter_session_token]
		session = Session.find_by(token: token)
		@tweet = Tweet.find_by(id: params[:id])

		if session and @tweet.destroy
			render json: { success: true }
		else
			render json: { success: false }
		end
	end

	private

	def tweet_params
		params.require(:tweet).permit(:message)
	end
end
