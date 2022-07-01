source "https://rubygems.org"

gem "sus", "~> 0.7"

group :maintenance, optional: true do
	gem "bake-modernize"
	gem "bake-gem"
	
	gem "bake-github-pages"
	gem "utopia-project"
end
