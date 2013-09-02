#= require jquery
#= require jquery_ujs
#= require twitter/bootstrap
#= require_tree .
#= require jquery.turbolinks
#= require markitup
#= require markitup/sets/markdown/set
#= require select2
#= require jquery.jqplot.min.js
#= require plugins/jqplot.dateAxisRenderer.min.js

jQuery ->
  $("#markItUp").markItUp markdownSettings
  $("#book_tag_list").select2({tags: $("#book_tag_list").data('autocomplete-source'), width: 240}  )