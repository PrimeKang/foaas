operation = require '../../lib/operations/that'

describe "/that", ->
  it "should have the correct name", ->
    expect(operation.name).toEqual('Fork That')

  it "should have the correct url", ->
    expect(operation.url).toEqual('/that/:from')

  it "should have the correct fields", ->
    expect(operation.fields).toEqual([
      { name: 'From', field: 'from'}
    ])

  describe 'register', ->
    it 'should call app.get with correct url', ->
      app =
        get: jasmine.createSpy()

      operation.register(app,null)

      expect(app.get).toHaveBeenCalled()
      expect(app.get.argsForCall[0][0]).toEqual('/that/:from')

    it 'should call output with correct params', ->
      func = null
      app =
        get: (url, fn) -> func = fn
      output = jasmine.createSpy()
      operation.register(app, output)

      req = 
        params:
          from: "TESTFROM"

      func(req,'RES')
      expect(output).toHaveBeenCalledWith(
        req,
        'RES',
        'Fork that.',
        '- TESTFROM'
      )