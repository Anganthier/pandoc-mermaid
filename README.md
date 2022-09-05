# pandoc-mermaid container

Container to generate pdf from markdown document with embedded mermaid diagrams.

The markdown file plus supporting files and filters must be provided to the container via a mounted volume. Mermaid uses headless chrome and hence must be run as non-root user. This is achieved by using docker run options '-u' with your userid and granting SYS_ADMIN privilege.  The generated file is written to the mounted volume.

## Build Container locally

```sh
docker build . -t pandoc-mermaid:latest
```

## Example Run

Example run to convert a markdown and supporting files into a PDF via docker run:

```sh
$ docker run -ti --rm -u id -u $USER --cap-add=SYS_ADMIN -v $PWD:/u \
  pandoc-mermaid \
  pandoc --pdf-engine=xelatex \
  --filter=pandoc_filter.py \
  EXAMPLE.md -o example.pdf
Unable to find image 'pandoc-mermaid:latest' locally
latest: Pulling from pandoc-mermaid
2746a4a261c9: Pull complete 
4c1d20cdee96: Pull complete 
0d3160e1d0de: Pull complete 
c8e37668deea: Pull complete 
da53c72146f0: Pull complete 
deee032a7485: Pull complete 
58f03f4eaca8: Pull complete 
6d5fe3e4784e: Pull complete 
2df2b2dbbc2a: Pull complete 
b660cbaefe06: Pull complete 
Digest: sha256:d5bcdf339636c9221682d16d42896429557ee5927001ee423353ae90fe778f23
Status: Downloaded newer image for marcelwiget/pandoc-mermaid:latest
Created directory mermaid-images
Created image mermaid-images/b6c0cfb045b80697bae20eef546e4268ab092b60.png
Doc Format  latex

$ ls 
Dockerfile  EXAMPLE.md  example.pdf  LICENSE  mermaid-images  pandoc_filter.py  README.md
```

Generated [example.pdf](example.pdf) file.

The folder mermaid-images contains the extracted mermaid markdown code and the generated images. This folder can be deleted after each run.

```sh
$ ls mermaid-images/
b6c0cfb045b80697bae20eef546e4268ab092b60.mmd  b6c0cfb045b80697bae20eef546e4268ab092b60.png
```

## Errors

If you get a similar error like:

```sh
node:child_process:915
    throw err;
    ^

Error: Command failed: "/usr/lib/node_modules/mermaid-filter/node_modules/.bin/mmdc"    -p /workdir/.puppeteer.json -w 800 -s 1 -f -i /tmp/tmp-12yfqf9vxW4GGf.tmp -t default -b white -o /tmp/tmp-12yfqf9vxW4GGf.tmp.png
/usr/lib/node_modules/mermaid-filter/node_modules/puppeteer/lib/cjs/puppeteer/node/BrowserRunner.js:241
            reject(new Error([
                   ^

Error: Failed to launch the browser process! spawn /usr/bin/chromium-browser ENOENT
```

Add a .puppeteer.json file with the following content:

```json
{
  "headless": true,
  "args": ["--no-sandbox"]
}
```
