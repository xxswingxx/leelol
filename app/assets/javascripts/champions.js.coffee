# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.onload = -> 
  updateStats = (object, inc) ->
    keys = Object.keys(object)

    for i in [0...keys.length]
      spanClass = keys[i].replace /[A-Z]/g, (match) ->
        '-' + match.toLowerCase()

      increment = parseFloat object[keys[i]]
      extra = parseFloat($(".extra##{spanClass}").data('extraAcumulation')) + increment
      $(".extra##{spanClass}").data('extraAcumulation', extra)
      $(".extra##{spanClass}").html("(+#{extra})")

  $('.tooltip-r').tooltip()
  $('.level-slider').bind "slider:changed", (event, data) ->
    $('span.level').html(data.value)
    lvl = data.value - 1

    baseHealth = parseFloat $('span.stat.health').data('health')
    healthPerLvl = parseFloat $('span.stat.health-per-lvl').html()
    $('span.stat.health').html((baseHealth + healthPerLvl * lvl).toFixed(2))

    baseMana = parseFloat $('span.stat.mana').data('mana')
    manaPerLvl = parseFloat $('span.stat.mana-per-lvl').html()
    $('span.stat.mana').html((baseMana + manaPerLvl * lvl).toFixed(2))

    baseAttack = parseFloat $('span.stat.attack-damage').data('attack-damage')
    attackPerLvl = parseFloat $('span.stat.attack-per-lvl').html()
    $('span.stat.attack-damage').html((baseAttack + attackPerLvl * lvl).toFixed(2))

    baseAttackSpeed = parseFloat $('span.stat.attack-speed').data('attack-speed')
    attackSpeedPerLvl = parseFloat($('span.stat.attack-speed-per-lvl').html()) / 100
    $('span.stat.attack-speed').html((baseAttackSpeed + (baseAttackSpeed * attackSpeedPerLvl * lvl)).toFixed(2))

    baseArmor = parseFloat $('span.stat.armor').data('armor')
    armorPerLvl = parseFloat $('span.stat.armor-per-lvl').html()
    $('span.stat.armor').html((baseArmor + armorPerLvl * lvl).toFixed(2))

    baseMagicRes = parseFloat $('span.stat.magic-resistance').data('magic-resistance')
    magicResPerLvl = parseFloat $('span.stat.magic-resist-per-lvl').html()
    $('span.stat.magic-resistance').html((baseMagicRes + magicResPerLvl * lvl).toFixed(2))
  
  $('.item-icon').on 'click', (e) ->
    e.preventDefault()
    elem = document.createElement("img")
    elem.setAttribute('src',$(this).find('.item-src img').attr('src') )
    $(elem).appendTo $($('.empty')[0])
    $($('.empty')[0]).data('cost', $(this).find('.item-src').data('cost'))
    $($('.empty')[0]).removeClass('empty')

    updateStats($(this).find('.hidden-data').data(), true)
    $('.build-cost').html(parseInt($('.build-cost').html()) + parseInt($(this).find('.item-src').data('cost')))

  $('.item-set').on 'click', (e) ->
    e.preventDefault()
    $(this).html('')
    if typeof $(this).data('cost') != 'undefined'
      $('.build-cost').html(parseInt($('.build-cost').html()) - parseInt($(this).data('cost')))
      $(this).data('cost', 0)
    $(this).addClass('empty')