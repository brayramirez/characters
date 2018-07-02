json.games do
  json.extract! game,
    :id,
    :code,
    :name,
    :status,
    :commander,
    :false_commander,
    :bodyguard,
    :blind_spy,
    :deep_cover,
    :host_id

  json.set! :is_owner, game.host_id == @current_player.id
end
