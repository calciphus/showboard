class MainController < ApplicationController

	# GET Display front page
	def index
		@fullcount = Interaction.count(:id)
		@unique_authors = Interaction.all.pluck(:author_name).uniq.size
		@title = sitevar("title")
		@photos = Interaction.where(:has_photo).count(:id)
		@news = Interaction.where(source_type: ["blog","board","lexisnexis","newscred","reddit","wikipedia","wordpress"]).count(:id)
		@comments = Interaction.where(source_type: ["intensedebate","disqus"]).count(:id)
		@clicks = Interaction.where(source_type: "bitly").count(:id)
		@leaderboard = Interaction.group(:author_name).count.sort_by { |name, count| -count }
	end
  
	# GET Returns JS to update front-page listing
	def update
	end

  	# POST Webhook for inbound JSON stream
  	def webhook
  		# Iterate through JSON "interactions" object
		if params[:interactions]
			params[:interactions].each do |iac|
				i = Interaction.new

				# Assign direct values where possible
				i.ds_id = iac[:interaction][:id]
				i.source_type = iac[:interaction][:type]
				i.content = iac[:interaction][:type] rescue nil
				i.author_id = iac[:interaction][:author][:id] rescue nil

				# Get Username and Name. If Username exists, use that, otherwise name, otherwise nil
				username = iac[:interaction][:author][:username] rescue nil
				name = iac[:interaction][:author][:name] rescue nil
				if username != nil
					i.author_name = username
				else
					i.author_name = name
				end

				# Iterate through links array and check to see if final URLs include image tags
				links = iac[:links][:normalized_url] rescue nil
				i.has_photo = false
				if links != nil
					links.each do |l|
						if l.include?(".png") or l.include?(".jpg") or l.include?(".gif")
							i.has_photo = true
						end
					end
				end

				# Check and see if the body text contains any of the tracking keywords or hashtags
				keywords = sitevar("keywords")
				i.body_match = false
				if i.content
					keywords.each do |k|
						if i.content.include?(k)
							i.body_match = true
						end
					end
				end

				kw = iac[:links][:meta][:keywords] rescue nil
				desc = iac[:links][:meta][:description] rescue nil
				ttl = iac[:links][:title] rescue nil 
				wordblob = "#{kw} #{desc} #{ttl}"

				if wordblob.strip != ""
					keywords.each do |k|
						if i.content.include?(k)
							i.link_match = true
						end
					end
				end

				i.save
			end
		end
		respond_to do |format|
			# Respond with success per Datasift documentation
			format.json{
				render :json => Hash["success" => true].to_json
			}
		end
	end
end