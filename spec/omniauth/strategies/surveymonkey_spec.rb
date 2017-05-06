require 'spec_helper'
require 'omniauth-burner'

describe OmniAuth::Strategies::Burner do
  before :each do
    @request = double('Request')
    @request.stub(:params) { {} }
    @request.stub(:cookies) { {} }
    
    @client_id = 'abc'
    @client_secret = 'def'
  end
  
  subject do
    args = [@client_id, @client_secret, @options].compact
    OmniAuth::Strategies::Burner.new(nil, *args).tap do |strategy|
      strategy.stub(:request) { @request }
    end
  end

  it_should_behave_like 'an oauth2 strategy'

  describe '#client' do
    it 'has correct site' do
      subject.client.site.should eq('https://app.burnerapp.com')
    end

    it 'has correct authorize url' do
      subject.client.options[:authorize_url].should eq('https://app.burnerapp.com/oauth/authorize')
    end

    it 'has correct token url' do
      subject.client.options[:token_url].should eq('https://api.burnerapp.com/oauth/access')
    end
  end

  describe '#uid' do
    before :each do
      subject.stub(:raw_info) { { 'id' => '123' } }
    end
    
    it 'returns the id from raw_info' do
      subject.uid.should eq('123')
    end
  end
  
  describe '#info' do
    before :each do
      @raw_info ||= { 'name' => 'Alex' }
      subject.stub(:raw_info) { @raw_info }
    end
    
    context 'when optional data is not present in raw info' do
      it 'has no email key' do
        subject.info.should_not have_key('email')
      end
    end
    
    context 'when data is present in raw info' do
      it 'returns first name' do
        subject.info['name'].should eq('Alex')
      end
    end
  end
  
  describe '#credentials' do
    before :each do
      @access_token = double('OAuth2::AccessToken')
      @access_token.stub(:token)
      @access_token.stub(:expires?)
      @access_token.stub(:expires_at)
      @access_token.stub(:refresh_token)
      subject.stub(:access_token) { @access_token }
    end
    
    it 'returns a Hash' do
      subject.credentials.should be_a(Hash)
    end
    
    it 'returns the token' do
      @access_token.stub(:token) { '123' }
      subject.credentials['token'].should eq('123')
    end
    
    it 'returns the expiry status' do
      @access_token.stub(:expires?) { true }
      subject.credentials['expires'].should eq(true)
      
      @access_token.stub(:expires?) { false }
      subject.credentials['expires'].should eq(false)
    end
    
    it 'returns the refresh token and expiry time when expiring' do
      ten_mins_from_now = (Time.now + 600).to_i
      @access_token.stub(:expires?) { true }
      @access_token.stub(:refresh_token) { '321' }
      @access_token.stub(:expires_at) { ten_mins_from_now }
      subject.credentials['refresh_token'].should eq('321')
      subject.credentials['expires_at'].should eq(ten_mins_from_now)
    end
    
    it 'does not return the refresh token when it is nil and expiring' do
      @access_token.stub(:expires?) { true }
      @access_token.stub(:refresh_token) { nil }
      subject.credentials['refresh_token'].should be_nil
      subject.credentials.should_not have_key('refresh_token')
    end
    
    it 'does not return the refresh token when not expiring' do
      @access_token.stub(:expires?) { false }
      @access_token.stub(:refresh_token) { 'XXX' }
      subject.credentials['refresh_token'].should be_nil
      subject.credentials.should_not have_key('refresh_token')
    end
  end
  
  describe '#extra' do
    before :each do
      @raw_info = { 'name' => 'Fred Smith' }
      subject.stub(:raw_info) { @raw_info }
    end
    
    it 'returns a Hash' do
      subject.extra.should be_a(Hash)
    end
  end

end
