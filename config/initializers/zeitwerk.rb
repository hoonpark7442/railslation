# Configures default inflections for the zeitwerk autoloader
# see <https://guides.rubyonrails.org/autoloading_and_reloading_constants.html#customizing-inflections>

Rails.autoloaders.each do |autoloader|
  autoloader.inflector.inflect(
    "html_rouge" => "HTMLRouge"
  )
end