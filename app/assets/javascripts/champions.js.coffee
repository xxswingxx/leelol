# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.onload = -> 
  calculateTotal = (name) ->
    base = parseFloat($(".stat.#{name}").html())
    extra = parseFloat($(".extra##{name}").data('extraAcumulation'))
    $(".total.#{name}").html(base + extra)

  keyToClass = (key) ->
    key.replace /[A-Z]/g, (match) ->
      '-' + match.toLowerCase()

  updateStats = (object, inc) ->
    keys = Object.keys(object)

    for i in [0...keys.length]
      className = keyToClass(keys[i])
      diff = parseFloat object[keys[i]]
      diff = diff * -1 if !inc

      extra = parseFloat($(".extra##{className}").data('extraAcumulation')) + diff
      $(".extra##{className}").data('extraAcumulation', extra)
      $(".extra##{className}").html("(+#{extra}) = ")
      calculateTotal(className)

  $('.tooltip-r').tooltip()
  $('.level-slider').bind "slider:changed", (event, data) ->
    $('.level').html(data.value)
    lvl = data.value - 1

    baseHealth = parseFloat $('.stat.health').data('health')
    healthPerLvl = parseFloat $('.stat.health-per-lvl').html()
    $('.stat.health').html((baseHealth + healthPerLvl * lvl).toFixed(2))
    calculateTotal('health')

    baseMana = parseFloat $('.stat.mana').data('mana')
    manaPerLvl = parseFloat $('.stat.mana-per-lvl').html()
    $('.stat.mana').html((baseMana + manaPerLvl * lvl).toFixed(2))
    calculateTotal('mana')

    baseAttack = parseFloat $('.stat.attack-damage').data('attack-damage')
    attackPerLvl = parseFloat $('.stat.attack-per-lvl').html()
    $('.stat.attack-damage').html((baseAttack + attackPerLvl * lvl).toFixed(2))
    calculateTotal('attack-damage')

    baseAttackSpeed = parseFloat $('.stat.attack-speed').data('attack-speed')
    attackSpeedPerLvl = parseFloat($('.stat.attack-speed-per-lvl').html()) / 100
    $('.stat.attack-speed').html((baseAttackSpeed + (baseAttackSpeed * attackSpeedPerLvl * lvl)).toFixed(2))
    calculateTotal('attack-speed')

    baseArmor = parseFloat $('.stat.armor').data('armor')
    armorPerLvl = parseFloat $('.stat.armor-per-lvl').html()
    $('.stat.armor').html((baseArmor + armorPerLvl * lvl).toFixed(2))
    calculateTotal('armor')

    baseMagicRes = parseFloat $('.stat.magic-resistance').data('magic-resistance')
    magicResPerLvl = parseFloat $('.stat.magic-resist-per-lvl').html()
    $('.stat.magic-resistance').html((baseMagicRes + magicResPerLvl * lvl).toFixed(2))
    calculateTotal('magic-resistance')

  $('.item-icon').on 'click', (e) ->
    e.preventDefault()
    if typeof $('.empty')[0] != 'undefined'
      elem = document.createElement("img")
      elem.setAttribute('src',$(this).find('.item-src img').attr('src') )
      $(elem).appendTo $($('.empty')[0])
      $($('.empty')[0]).data('cost', $(this).find('.item-src').data('cost'))
      $($('.empty')[0]).attr('data-item-id', $(this).find('.hidden-data').data('id'))
      $($('.empty')[0]).removeClass('empty')
      updateStats($(this).find('.hidden-data').data(), true)
      $('.build-cost').html(parseInt($('.build-cost').html()) + parseInt($(this).find('.item-src').data('cost')))

  $('.item-set').on 'click', (e) ->
    e.preventDefault()
    $(this).html('')
    if typeof $(this).data('cost') != 'undefined'
      $('.build-cost').html(parseInt($('.build-cost').html()) - parseInt($(this).data('cost')))
      itemId = $(this).attr('data-item-id')
      statData = $(".hidden-data.item-#{itemId}").data()
      updateStats(statData, false) if statData != null
      $(this).attr('data-item-id', '')
      $(this).data('cost', 0)
      $(this).addClass('empty')