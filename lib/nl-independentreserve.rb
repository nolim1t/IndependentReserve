require 'openssl'
require 'json'
require 'digest/md5'
require 'httparty'


class IndependentReserve
	include HTTParty
	base_uri 'https://api.independentreserve.com'

	def initialize(options={})
		@apisecret = ENV['access_secret']
		@apikey = ENV['access_key']
		if options[:primaryCurrency] != nil then
			@primaryCurrency = options[:primaryCurrency]
		end
		if options[:secondaryCurrency] != nil then
			@secondaryCurrency = options[:secondaryCurrency]
		end
	end

  def method_missing(method_sym, *arguments, &block)
		pub_or_priv = 'private'
		if method_sym.to_s.scan("public").length > 0 then
			pub_or_priv = 'public'
		end

		convert_undercores_to_slashes = method_sym.to_s.gsub('_','/')
		convert_undercores_to_slashes = convert_undercores_to_slashes.gsub('public', 'Public')
		convert_undercores_to_slashes = convert_undercores_to_slashes.gsub('private', 'Private')
		nonce = (Time.now.to_f * 1000).to_i
		to_sign = nonce.to_s + @apikey
		ssl_sign = OpenSSL::HMAC.hexdigest('sha256', @apisecret, to_sign)
		signed = ssl_sign.upcase

		additionals = ''
		json_to_post = {}

		if @primaryCurrency != nil
			json_to_post[:primaryCurrencyCode] = @primaryCurrency
			json_to_post[:secondaryCurrencyCode] = @secondaryCurrency
			json_to_post[:nonce] = nonce
			json_to_post[:signature] = signed
			json_to_post[:apiKey] = @apikey

			additionals = 'nonce=' + nonce.to_s + '&signature=' + signed + '&apiKey=' + @apikey + '&primaryCurrencyCode=' + @primaryCurrency
			
			if @secondaryCurrency != nil
				additionals = additionals + '&secondaryCurrencyCode=' + @secondaryCurrency
			end
		end
		if arguments.length == 1 then
			if arguments[0].kind_of? Hash then
				arguments[0].each {|k,v| 
					additionals = additionals + "#{@values}&#{k}=#{v}"
					json_to_post["#{k}"] = v
				}
			end
		end

		headers  = {'Content-Type' => 'application/json'}
		if pub_or_priv == 'private' then
			self.class.post('/' + convert_undercores_to_slashes, :body => json_to_post.to_json, :headers => headers).to_json
		else
			self.class.get('/' + convert_undercores_to_slashes + '?' + additionals).to_json
		end
	end
end
