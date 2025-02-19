require 'spec_helper'

describe Capybara::Mechanize::Driver do
  before(:each) do
    Capybara.app_host = REMOTE_TEST_URL
  end
  
  after(:each) do
    Capybara.app_host = nil
  end

  before do
    @driver = Capybara::Mechanize::Driver.new
  end
  
  context "in remote mode" do
    it "should not throw an error when no rack app is given" do
      running do
        Capybara::Mechanize::Driver.new
      end.should_not raise_error(ArgumentError)
    end
    
    it "should pass arguments through to a get request" do
      @driver.visit("#{REMOTE_TEST_URL}/form/get", {:form => "success"})
      @driver.body.should include('success')
    end

    it "should pass arguments through to a post request" do
      @driver.post("#{REMOTE_TEST_URL}/form", {:form => "success"})
      @driver.body.should include('success')
    end

    context "for a post request" do

      it "should transform nested map in post data" do
        @driver.post("#{REMOTE_TEST_URL}/form", {:form => {:key => "value"}})
        @driver.body.should include('key: value')
      end

    end

    context "process remote request" do

      it "should transform nested map in post data" do
        @driver.submit(:post, "#{REMOTE_TEST_URL}/form", {:form => {:key => "value"}})
        @driver.body.should include('key: value')
      end

    end

    it_should_behave_like "driver"
    it_should_behave_like "driver with header support"
    it_should_behave_like "driver with status code support"
    it_should_behave_like "driver with cookies support"
    it_should_behave_like "driver with infinite redirect detection"
  end
  
end

describe "Capybara::Mechanize::Driver, browser" do
  
  before(:each) do
    Capybara.app_host = REMOTE_TEST_URL
  end

  after(:each) do
    Capybara.app_host = nil
  end
  
  context "in remote mode" do
    it "should not throw an error when empty option is passed" do
      running do
        Capybara::Mechanize::Driver.new(ExtendedTestApp, {})
      end.should_not raise_error()
    end

    it "should throw an error when bad proxy option is passed" do
      running do
        Capybara::Mechanize::Driver.new(ExtendedTestApp, {:proxy => BAD_PROXY}).browser
      end.should raise_error("ProxyError: You have entered an invalid proxy address #{BAD_PROXY}. e.g. (http|https)://proxy.com(:port)")
    end

    it "should not throw an error when good proxy option is passed" do
      running do
        Capybara::Mechanize::Driver.new(ExtendedTestApp, {:proxy => GOOD_PROXY}).browser
      end.should_not raise_error()
    end

    it "should not throw an error when good proxy with port option is passed" do
      running do
        Capybara::Mechanize::Driver.new(ExtendedTestApp, {:proxy => PROXY_WITH_PORT}).browser
      end.should_not raise_error()
    end
  end
end
