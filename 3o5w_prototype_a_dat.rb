# 3o5w_prototype_a_dat.rb

# API Specification for Data-Driven Security Tool Analyzer

require 'json'
require 'rest-client'

class SecurityToolAnalyzer
  def initialize(api_key, base_url)
    @api_key = api_key
    @base_url = base_url
  end

  def analyze_tool(tool_name)
    response = RestClient.get("#{@base_url}/tools/#{tool_name}", {
      params: { api_key: @api_key }
    })

    json_response = JSON.parse(response.body)

    # Extract relevant information from the response
    {
      name: json_response['name'],
      description: json_response['description'],
      vulnerabilities: json_response['vulnerabilities'].map { |v| v['name'] },
      threat_level: json_response['threat_level']
    }
  end

  def get_supported_tools
    response = RestClient.get("#{@base_url}/tools", {
      params: { api_key: @api_key }
    })

    json_response = JSON.parse(response.body)

    json_response['tools'].map { |tool| tool['name'] }
  end
end

# Example usage
analyzer = SecurityToolAnalyzer.new('YOUR_API_KEY', 'https://api.example.com')
supported_tools = analyzer.get_supported_tools
puts "Supported tools: #{supported_tools.join(', ')}"

tool_analysis = analyzer.analyze_tool('ToolX')
puts "ToolX analysis: #{tool_analysis.inspect}"