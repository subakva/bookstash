# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# .bind('ajax:loading')
# .bind('ajax:failure')
$ ->
  $('.new_book').bind('ajax:success', (event, data, status, xhr) ->
    $('#book_list').append("<li>#{data.title}</li>");
  );

  $('.delete-book').bind('ajax:success', (event, data, status, xhr) ->
    $(this).parent().remove();
  );

