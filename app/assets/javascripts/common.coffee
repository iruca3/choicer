$(window).on( 'load page:load pagechange ajax:complete', ->
  if $('.container').height() < window.innerHeight - 60
    $('.container').height( window.innerHeight - 60 )
  
)
