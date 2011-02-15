class SearchesController < ApplicationController
  
  def show
    if params[:query]
      @gems = Rubygem.search(params[:query]).with_versions.paginate(:page => params[:page])
      @exact_match = Rubygem.name_is(params[:query]).with_versions.first
    end
  end
  
  # Renders the search view.
  #
  def index
    
  end
  
  # For full results, you get the ids from the picky server
  # and then populate the result with models (rendered, even).
  #
  def full
    results = FullGems.search params[:query], :offset => params[:offset]

    results.extend Picky::Convenience
    results.populate_with AGem do |a_gem|
      a_gem.to_s
    end

    response['Cache-Control'] = 'public, max-age=36000'
    
    ActiveSupport::JSON.encode results
  end

  # For live results, you'd actually go directly to the search server without taking the detour.
  #
  def live
    response['Cache-Control'] = 'public, max-age=36000'
    
    LiveGems.search params[:query], :offset => params[:offset]
  end

end
