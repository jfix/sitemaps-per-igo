const readline = require('readline')
const fs = require('fs')

const rl = readline.createInterface({
  input: fs.createReadStream('out.txt'),
  crlfDelay: Infinity
})
const config = {
  'oecd': {
    'prefix': 'https://www.oecd-ilibrary.org/'
  },
  'unp': {
    'prefix': 'https://www.un-ilibrary.org/'
  },
  'cw': {
    'prefix': 'https://www.thecommonwealth-ilibrary.org/'
  },
  'itu': {
    'prefix': 'https://www.itu-ilibrary.org/'
  },
  'ncm': {
    'prefix': 'https://www.norden-ilibrary.org/'
  }
}
const prepend = '<?xml version="1.0" encoding="UTF-8"?>\n<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n'
const append = '</urlset>\n'
const infix = '-sitemap.xml'

rl.on('line', (line) => {
  const [igo, alias] = line.split('\t')
  if (!config[igo]) {
    console.log(`*** FIXME ==> NO-IGO: ${line}`)
  } else {
    const prefix = config[igo].prefix
    const fileName = `${igo}${infix}`

    fs.appendFile(fileName, `<url><loc>${prefix}${alias}</loc></url>\n`, (err) => {
      if (err) throw err
    })
  }
})

rl.on('close', () => {
  // write closing tag to all open files
  // then close all open files
  Object.keys(config).forEach((key) => {
    fs.appendFile(`${key}${infix}`, append)
  })
})

// initialize XML file with what's necessary
Object.keys(config).forEach((key) => {
  fs.writeFileSync(`${key}${infix}`, prepend, {'encoding': 'utf8'})
})
