# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.onload = -> 
  keyToClass = (object) ->
    keys = Object.keys(object)
    for i in [0...keys.length]
      switch keys[i]
        when 'armor'
          1
        when 'abilityPower'
          1
        when '%CriticalStrikeChance'
          1
        when 'health'
          1
        when 'magicResist'
          1
        when 'mana'
          1
        when 'manaRegenPer5Seconds'
          1

  updateStats = (object, incOrDec) ->
    1 + 1

  $('.tooltip-r').tooltip()
  $('.level-slider').bind "slider:changed", (event, data) ->
    $('span.level').html(data.value)

    baseHealth = parseFloat $('span.stat.health').data('health')
    healthPerLvl = parseFloat $('span.stat.health-per-lvl').html()
    $('span.stat.health').html((baseHealth + healthPerLvl * (data.value - 1)).toFixed(2))

    baseMana = parseFloat $('span.stat.mana').data('mana')
    manaPerLvl = parseFloat $('span.stat.mana-per-lvl').html()
    $('span.stat.mana').html((baseMana + manaPerLvl * (data.value - 1)).toFixed(2))

    baseAttack = parseFloat $('span.stat.attack').data('attack')
    attackPerLvl = parseFloat $('span.stat.attack-per-lvl').html()
    $('span.stat.attack').html((baseAttack + attackPerLvl * (data.value - 1)).toFixed(2))

    baseAttackSpeed = parseFloat $('span.stat.attack-speed').data('attack-speed')
    attackSpeedPerLvl = parseFloat($('span.stat.attack-speed-per-lvl').html()) / 100
    $('span.stat.attack-speed').html((baseAttackSpeed + (baseAttackSpeed * attackSpeedPerLvl * (data.value - 1))).toFixed(2))

    baseArmor = parseFloat $('span.stat.armor').data('armor')
    armorPerLvl = parseFloat $('span.stat.armor-per-lvl').html()
    $('span.stat.armor').html((baseArmor + armorPerLvl * (data.value - 1)).toFixed(2))

    baseMagicRes = parseFloat $('span.stat.magic-resist').data('magic-resist')
    magicResPerLvl = parseFloat $('span.stat.magic-resist-per-lvl').html()
    $('span.stat.magic-resist').html((baseMagicRes + magicResPerLvl * (data.value - 1)).toFixed(2))
  
  $('.item-icon').on 'click', (e) ->
    e.preventDefault()

    elem = document.createElement("img")
    elem.setAttribute('src',$(this).find('.item-src img').attr('src') )
    $(elem).appendTo $($('.empty')[0])
    $($('.empty')[0]).removeClass('empty')

  $('.item-set').on 'click', (e) ->
    e.preventDefault()
    $(this).html('')
    $(this).addClass('empty')