parser =
  parse: (text) ->
    if typeof text isnt 'string'
      return []
    lines = text.split('\n')
    result = []
    for line in lines
      tmp = line.split(/: /)
      if tmp.length isnt 3
        continue
      type = tmp[1]
      place = tmp[0].split(':')
      if place.length <= 1 or  isNaN(Number(place[place.length - 2]))
        file = ''
        for i in [0...place.length]
          if i isnt 0
            file += ':'
          file += place[i]
        console.log file
        where = undefined
      else
        file = ''
        for i in [0...place.length - 2]
          if i isnt 0
            file += ':'
          file += place[i]
          where =
            line: place[place.length - 2]
            col: place[place.length - 1]
      desc = tmp[2]
      result.push(
        file: file
        type: type
        desc: desc
        where: where
      )
    return result
module.exports = parser
