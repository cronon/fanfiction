#= require jquery
#= require jquery_ujs
#= require twitter/bootstrap
#= require turbolinks
#= require_tree .
#= require markitup
#= require markitup/sets/markdown/set
jQuery ->
  $("textarea").markItUp markdownSettings
