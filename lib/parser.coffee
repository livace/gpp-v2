parser =
  parse: (text) ->
    console.log(typeof text)
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
      if place.length is 1 or Number(place[place.length - 2]) is NaN
        file = ''
        for i in [0...place.length]
          if i isnt 0
            file += ':'
          file += place[i]
        where =
          col: ''
          row: ''
      else
        file = ''
        for i in [0...place.length - 2]
          if i isnt 0
            file += ':'
          file += place[i]
          where =
            col: place[place.length - 2]
            row: place[place.length - 1]
      desc = tmp[2]
      result.push(
        file: file
        type: type
        desc: desc
        where: where
      )
    return result
module.exports = parser
