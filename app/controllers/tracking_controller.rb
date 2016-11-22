class TrackingController < ApplicationController
  def index
    @title = "トラッキングサンプル2"
    @lead_sources = LeadSource.all
  end
end
