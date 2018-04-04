require "spec_helper"
require 'render_as_js/view_helpers' #otherwise done by the railtie, which we're skipping for now

# require ""

class TestViewHelper
  include ViewHelpers
  include ActionView::Helpers::SanitizeHelper
end
helper = TestViewHelper.new

RSpec.describe RenderAsJs do

  describe "#string_to_js_obj" do
    it "should work add quotes around a string" do
      expect(helper.render_as_js("a")).to eq("'a'")
    end
    it "should work with already quoted strings" do
      expect(helper.render_as_js("'a'")).to eq("'\'a\''")
    end
  end
  describe "#date_to_js_obj" do
    it "should initialize a new date when date is passed" do
      a = Date.new(2017,1,1)
      expect(helper.render_as_js(a)).to eq("new Date('2017-01-01')");
    end
    it "should initialize a new date when dateTIME is passed" do
      a = DateTime.new(2017,1,1,10,11)
      expect(helper.render_as_js(a)).to eq("new Date('2017-01-01T10:11:00+00:00')");
    end
  end
  describe "#array_to_js_obj" do
    it "should render a proper array" do
      a = [1, "Abc"]
      expect(helper.render_as_js(a)).to eq("[1, 'Abc']")
    end
  end
  describe "#symbol_to_js_obj" do
    it "should render as string by default" do
      a = :symbol
      expect(helper.render_as_js(a)).to eq("'symbol'")
    end
    it "should render as unquoted when possible and key=true option is given" do
      a = :symbol
      expect(helper.render_as_js(a, key: true)).to eq("symbol")
    end
  end
  describe "#hash_to_js_obj" do
    it "should render a simple hash" do
      a = {a: 1}
      expect(helper.render_as_js(a)).to eq("{a: 1}")
    end
    it "should render a string key based hash" do
      a = {"1 23": 1}
      expect(helper.render_as_js(a)).to eq("{'1 23': 1}")
      a = {"123": 1}
      expect(helper.render_as_js(a)).to eq("{'123': 1}")
    end
  end
  describe "render_as_js" do
    it "shoudl render integrated" do
      a = [{y: 12, x:Date.new(2017,1,1)}, {y: 12, x: Date.new(2017,1,2)}]
      expect(helper.render_as_js(a)).to eq("[{y: 12, x: new Date('2017-01-01')}, {y: 12, x: new Date('2017-01-02')}]")
    end
  end
end
