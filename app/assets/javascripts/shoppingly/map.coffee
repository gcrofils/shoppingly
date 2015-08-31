class @Shoppingly.Map
  
  nearMapPath         = '/do/map/near.json'
  staticMapPath       = '/do/map/static.json'
  selectableMapPath   = '/do/map/selectable.json'
  selectedMarkerPath  = '/assets/maps/marker.png'
  MarkerPath          = '/assets/maps/pointer.png'
  
  constructor: ->
    @handler = Gmaps.build("Google")
    @markers = []
    @establishmentids = []
    
  @buildNear: (center, persistedEstablishmentIds)->
    window.shoppingly = new Shoppingly.Map
    shoppingly.center = center
    shoppingly.persistedEstablishmentIds = persistedEstablishmentIds
    shoppingly.buildNear()
    
  # shortcuts 
  addMarker: (marker) ->
    @handler.addMarker marker
    
  getMap: ->
    @handler.getMap()
    
  # Near Map  
  findMarkerbyEstablishmentId: (EstablishmentId) ->
    results = $.grep @markers, (marker) ->
      return marker.serviceObject.establishment.id == EstablishmentId
    results[0]
    
  selectMarker: (marker) ->
    @establishmentids.push marker.establishment.id
    marker.setIcon selectedMarkerPath
    marker.set 'selected', true
    
  unSelectMarker: (marker) ->
    @establishmentids = $.grep(@establishmentids, (value) ->
      return value != marker.establishment.id
    )
    marker.set 'selected', false
    marker.setIcon MarkerPath
  
  unselectedMarkers: ->
    $.grep @markers, (marker) =>
      return $.inArray(marker.serviceObject.establishment.id, @establishmentids) < 0
      
  removeUnselectedMarkers: ->
    @handler.removeMarkers @unselectedMarkers()
    
  addEstablishmentMarkers: (establishmentIds) ->
    return if establishmentIds.length < 1
    $.getJSON selectableMapPath, 
        ids: establishmentIds
      .done (data) ->
        shoppingly.drawMarkers data, true
          
  drawMarkers: (data, selected=false) =>
    for m in data 
      marker = shoppingly.addMarker(m)
      marker.serviceObject.set "establishment", m.establishment
      marker.serviceObject.set "selected", selected
      @selectMarker marker.serviceObject if selected
      @markers.push(marker)
      mkr = marker.getServiceObject()
      google.maps.event.addListener mkr, 'dblclick', ->
        if this.selected  
          Shoppingly.Itinerary.remove_stop_from_map this.establishment
          shoppingly.unSelectMarker this
        else
          Shoppingly.Itinerary.add_stop this.establishment
          shoppingly.selectMarker this
    
      
  updateNearMarkers: (latLng) =>
    $.getJSON nearMapPath,
        latitude: latLng.k
        longitude: latLng.D
        e: @establishmentids
      .done (data) ->
        shoppingly.drawMarkers data
        shoppingly.handler.resetBounds()
        shoppingly.handler.bounds.extendWith shoppingly.markers
        shoppingly.handler.fitMapToBounds()
 
  buildNear: ->
    @handler.buildMap
      provider:
        disableDefaultUI: false
        disableDoubleClickZoom: true
        mapMaker: false
        zoom: 14
        center: @center
        styles: [ featureType: "poi.business", stylers: [ { visibility: "off" } ] ]
      internal:
        id: "map"
    , => 
      shoppingly.addEstablishmentMarkers @persistedEstablishmentIds
      google.maps.event.addListener shoppingly.getMap(), 'click', (e)->
        shoppingly.removeUnselectedMarkers()
        shoppingly.updateNearMarkers e.latLng
     
  

