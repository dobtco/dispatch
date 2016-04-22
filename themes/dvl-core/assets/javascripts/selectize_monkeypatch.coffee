# Monkeypatch Selectize to not use "item" class, which conlflits with dvl-core...
oldSetupTemplates = Selectize::setupTemplates

Selectize::setupTemplates = ->
  oldSetupTemplates.apply(@, arguments)
  @settings.render.item = (data, escape) ->
    """
      <div class="selectize-item">#{escape(data[@settings.labelField])}</div>
    """
