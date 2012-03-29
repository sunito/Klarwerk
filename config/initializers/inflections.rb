# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format 
# (all these examples are active by default):
# ActiveSupport::Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end
ActiveSupport::Inflector.inflections do |inflect|
  inflect.plural /^(.+)ung$/i, '\1ungen'
  inflect.singular /^(.+)ungen$/i, '\1ung'

  inflect.plural /(eit)$/i, '\1en'
  inflect.singular /(eit)en$/i, '\1'
  #nflect.irregular 'zeit', 'zeiten'

  inflect.plural /^(.+)e$/i, '\1en'
  inflect.singular /^(.+[^gt])en$/i, '\1e'
  
  inflect.irregular 'messpunkt', 'messpunkte'
  inflect.irregular 'diagramm', 'diagramme'


#  inflect.uncountable %w( steuerung )

  #inflect.irregular 'quelle', 'quellen'
end
