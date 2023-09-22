

# go

```bash
PowerShell 7.3.7
PS C:\Users\wl> go env
set GO111MODULE=
set GOARCH=386
set GOBIN=
set GOCACHE=C:\Users\wl\AppData\Local\go-build
set GOENV=C:\Users\wl\AppData\Roaming\go\env
set GOEXE=.exe
set GOEXPERIMENT=
set GOFLAGS=
set GOHOSTARCH=386
set GOHOSTOS=windows
set GOINSECURE=
set GOMODCACHE=C:\Users\wl\go\pkg\mod
set GONOPROXY=
set GONOSUMDB=
set GOOS=windows
set GOPATH=C:\Users\wl\go
set GOPRIVATE=
set GOPROXY=https://goproxy.io,direct
set GOROOT=D:\app\golang
set GOSUMDB=sum.golang.org
set GOTMPDIR=
set GOTOOLCHAIN=auto
set GOTOOLDIR=D:\app\golang\pkg\tool\windows_386
set GOVCS=
set GOVERSION=go1.21.0
set GCCGO=gccgo
set GO386=sse2
set AR=ar
set CC=gcc
set CXX=g++
set CGO_ENABLED=0
set GOMOD=NUL
set GOWORK=
set CGO_CFLAGS=-O2 -g
set CGO_CPPFLAGS=
set CGO_CXXFLAGS=-O2 -g
set CGO_FFLAGS=-O2 -g
set CGO_LDFLAGS=-O2 -g
set PKG_CONFIG=pkg-config
set GOGCCFLAGS=-m32 -fno-caret-diagnostics -Qunused-arguments -Wl,--no-gc-sections -fmessage-length=0 -ffile-prefix-map=C:\Users\wl\AppData\Local\Temp\go-build2026190783=/tmp/go-build -gno-record-gcc-switches








```







```bash
# git
# go
# npm
# npm install -g sass
# 安装 C 编译器，GCC或Clang
sudo dnf install hugo


# 使用 Sass 语言的最新功能时，需要使用 Dart Sass 将 Sass 转译为 CSS。

[root@node193 ~]# git version
git version 2.41.0
[root@node193 ~]# go version
go version go1.19.10 linux/amd64
[root@node193 ~]# npm --version
8.19.2
[root@node193 ~]# sass --version
1.68.0 compiled with dart2js 3.1.2
[root@node193 ~]# 

npm install -D autoprefixer
npm install -D postcss-cli
npm install -D postcss




```



### powershell：https://gohugo.io/getting-started/quick-start/

```bash
# 是powershell 不是windows powershell，两者不相同
hugo new site quickstart
cd quickstart
git init
git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke.git themes/ananke
echo "theme = 'ananke'" >> hugo.toml
hugo server


PS C:\Users\wl> hugo new site quickstart
Congratulations! Your new Hugo site was created in C:\Users\wl\quickstart.

Just a few more steps...

1. Change the current directory to C:\Users\wl\quickstart.
2. Create or install a theme:
   - Create a new theme with the command "hugo new theme <THEMENAME>"
   - Install a theme from https://themes.gohugo.io/
3. Edit hugo.toml, setting the "theme" property to the theme name.
4. Create new content with the command "hugo new content <SECTIONNAME>\<FILENAME>.<FORMAT>".
5. Start the embedded web server with the command "hugo server --buildDrafts".

See documentation at https://gohugo.io/.
PS C:\Users\wl> cd quickstart
PS C:\Users\wl\quickstart> git init
Initialized empty Git repository in C:/Users/wl/quickstart/.git/
PS C:\Users\wl\quickstart> git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke.git themes/ananke
Cloning into 'C:/Users/wl/quickstart/themes/ananke'...
remote: Enumerating objects: 2659, done.
remote: Counting objects: 100% (88/88), done.
remote: Compressing objects: 100% (53/53), done.
remote: Total 2659 (delta 37), reused 63 (delta 28), pack-reused 2571
Receiving objects: 100% (2659/2659), 4.51 MiB | 519.00 KiB/s, done.
Resolving deltas: 100% (1470/1470), done.
warning: in the working copy of '.gitmodules', LF will be replaced by CRLF the next time Git touches it
PS C:\Users\wl\quickstart> echo "theme = 'ananke'" >> hugo.toml
PS C:\Users\wl\quickstart> hugo server
Watching for changes in C:\Users\wl\quickstart\{archetypes,assets,content,data,i18n,layouts,static,themes}
Watching for config changes in C:\Users\wl\quickstart\hugo.toml, C:\Users\wl\quickstart\themes\ananke\config.yaml
Start building sites …
hugo v0.118.2-da7983ac4b94d97d776d7c2405040de97e95c03d+extended windows/amd64 BuildDate=2023-08-31T11:23:51Z VendorInfo=gohugoio


                   | EN
-------------------+-----
  Pages            |  7
  Paginator pages  |  0
  Non-page files   |  0
  Static files     |  1
  Processed images |  0
  Aliases          |  0
  Sitemaps         |  1
  Cleaned          |  0

Built in 108 ms
Environment: "development"
Serving pages from memory
Running in Fast Render Mode. For full rebuilds on change: hugo server --disableFastRender
Web Server is available at http://localhost:1313/ (bind address 127.0.0.1)
Press Ctrl+C to stop
```





# 命令行



##  hugo version

```bash
PS C:\Users\wl> hugo version
hugo v0.118.2-da7983ac4b94d97d776d7c2405040de97e95c03d+extended windows/amd64 BuildDate=2023-08-31T11:23:51Z VendorInfo=gohugoio




```



## hugo help

```bash
PS C:\Users\wl> hugo help
hugo is the main command, used to build your Hugo site.

Hugo is a Fast and Flexible Static Site Generator
built with love by spf13 and friends in Go.

Complete documentation is available at https://gohugo.io/.

Usage:
  hugo [flags]
  hugo [command]

Available Commands:
  completion  Generate the autocompletion script for the specified shell
  config      Print the site configuration
  convert     Convert your content to different formats
  deploy      Deploy your site to a Cloud provider.
  env         Print Hugo version and environment info
  gen         A collection of several useful generators.
  help        Help about any command
  import      Import your site from others.
  list        Listing out various types of content
  mod         Various Hugo Modules helpers.
  new         Create new content for your site
  server      A high performance webserver
  version     Print Hugo version and environment info

Flags:
  -b, --baseURL string             hostname (and path) to the root, e.g. https://spf13.com/
  -D, --buildDrafts                include content marked as draft
  -E, --buildExpired               include expired content
  -F, --buildFuture                include content with publishdate in the future
      --cacheDir string            filesystem path to cache directory
      --cleanDestinationDir        remove files from destination not found in static directories
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
  -c, --contentDir string          filesystem path to content directory
      --debug                      debug output
  -d, --destination string         filesystem path to write files to
      --disableKinds strings       disable different kind of pages (home, RSS etc.)
      --enableGitInfo              add Git revision, date, author, and CODEOWNERS info to the pages
  -e, --environment string         build environment
      --forceSyncStatic            copy all files when static is changed.
      --gc                         enable to run some cleanup tasks (remove unused cache files) after the build
  -h, --help                       help for hugo
      --ignoreCache                ignores the cache directory
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
  -l, --layoutDir string           filesystem path to layout directory
      --logLevel string            log level (debug|info|warn|error)
      --minify                     minify any supported output format (HTML, XML etc.)
      --noBuildLock                don't create .hugo_build.lock file
      --noChmod                    don't sync permission mode of files
      --noTimes                    don't sync modification time of files
      --panicOnWarning             panic on first WARNING log
      --poll string                set this to a poll interval, e.g --poll 700ms, to use a poll based approach to watch for file system changes
      --printI18nWarnings          print missing translations
      --printMemoryUsage           print memory usage to screen at intervals
      --printPathWarnings          print warnings on duplicate target paths etc.
      --printUnusedTemplates       print warnings on unused templates.
      --quiet                      build in quiet mode
      --renderToMemory             render to memory (only useful for benchmark testing)
  -s, --source string              filesystem path to read files relative from
      --templateMetrics            display metrics about template executions
      --templateMetricsHints       calculate some improvement hints when combined with --templateMetrics
  -t, --theme strings              themes to use (located in /themes/THEMENAME/)
      --themesDir string           filesystem path to themes directory
      --trace file                 write trace to file (not useful in general)
  -v, --verbose                    verbose output
  -w, --watch                      watch filesystem for changes and recreate as needed

Use "hugo [command] --help" for more information about a command.


###############################################################################

PS C:\Users\wl> hugo server --help
Hugo provides its own webserver which builds and serves the site.
While hugo server is high performance, it is a webserver with limited options.

'hugo server' will avoid writing the rendered and served content to disk,
preferring to store it in memory.

By default hugo will also watch your files for any changes you make and
automatically rebuild the site. It will then live reload any open browser pages
and push the latest content to them. As most Hugo sites are built in a fraction
of a second, you will be able to save and see your changes nearly instantly.

Usage:
  hugo server [command] [flags]
  hugo server [command]

Aliases:
  server, serve

Available Commands:
  trust       Install the local CA in the system trust store.

Flags:
      --appendPort             append port to baseURL (default true)
  -b, --baseURL string         hostname (and path) to the root, e.g. https://spf13.com/
      --bind string            interface to which the server will bind (default "127.0.0.1")
  -D, --buildDrafts            include content marked as draft
  -E, --buildExpired           include expired content
  -F, --buildFuture            include content with publishdate in the future
      --cacheDir string        filesystem path to cache directory
      --cleanDestinationDir    remove files from destination not found in static directories
  -c, --contentDir string      filesystem path to content directory
      --disableBrowserError    do not show build errors in the browser
      --disableFastRender      enables full re-renders on changes
      --disableKinds strings   disable different kind of pages (home, RSS etc.)
      --disableLiveReload      watch without enabling live browser reload on rebuild
      --enableGitInfo          add Git revision, date, author, and CODEOWNERS info to the pages
      --forceSyncStatic        copy all files when static is changed.
      --gc                     enable to run some cleanup tasks (remove unused cache files) after the build
  -h, --help                   help for server
      --ignoreCache            ignores the cache directory
  -l, --layoutDir string       filesystem path to layout directory
      --liveReloadPort int     port for live reloading (i.e. 443 in HTTPS proxy situations) (default -1)
      --meminterval string     interval to poll memory usage (requires --memstats), valid time units are "ns", "us" (or "µs"), "ms", "s", "m", "h". (default "100ms")
      --memstats string        log memory usage to this file
      --minify                 minify any supported output format (HTML, XML etc.)
      --navigateToChanged      navigate to changed content file on live browser reload
      --noBuildLock            don't create .hugo_build.lock file
      --noChmod                don't sync permission mode of files
      --noHTTPCache            prevent HTTP caching
      --noTimes                don't sync modification time of files
      --panicOnWarning         panic on first WARNING log
      --poll string            set this to a poll interval, e.g --poll 700ms, to use a poll based approach to watch for file system changes
  -p, --port int               port on which the server will listen (default 1313)
      --printI18nWarnings      print missing translations
      --printMemoryUsage       print memory usage to screen at intervals
      --printPathWarnings      print warnings on duplicate target paths etc.
      --printUnusedTemplates   print warnings on unused templates.
      --renderStaticToDisk     serve static files from disk and dynamic files from memory
      --renderToDisk           serve all files from disk (default is from memory)
      --templateMetrics        display metrics about template executions
      --templateMetricsHints   calculate some improvement hints when combined with --templateMetrics
  -t, --theme strings          themes to use (located in /themes/THEMENAME/)
      --tlsAuto                generate and use locally-trusted certificates.
      --tlsCertFile string     path to TLS certificate file
      --tlsKeyFile string      path to TLS key file
      --trace file             write trace to file (not useful in general)
  -w, --watch                  watch filesystem for changes and recreate as needed (default true)

Global Flags:
      --clock string               set the clock used by Hugo, e.g. --clock 2021-11-06T22:30:00.00+09:00
      --config string              config file (default is hugo.yaml|json|toml)
      --configDir string           config dir (default "config")
      --debug                      debug output
  -d, --destination string         filesystem path to write files to
  -e, --environment string         build environment
      --ignoreVendorPaths string   ignores any _vendor for module paths matching the given Glob pattern
      --logLevel string            log level (debug|info|warn|error)
      --quiet                      build in quiet mode
  -s, --source string              filesystem path to read files relative from
      --themesDir string           filesystem path to themes directory
  -v, --verbose                    verbose output

Use "hugo server [command] --help" for more information about a command.
PS C:\Users\wl>
```





## hugo：部署



```bash

# 创建网站
# 如上所述，Hugo 在构建站点之前不会清除公共目录。在每次构建之前手动清除公共目录的内容，以删除草稿、过期和未来的内容。



```







## hugo server



```bash


# 编辑内容时，如果您希望浏览器自动重定向到您上次修改的页面，请运行：
hugo server --navigateToChanged
```



## hugo new theme ：创建主题







## hugo mod graph：打印依赖图







## hugo mod get -u：更新所有模块





## hugo mod init ：初始化一个模块









# 配置



```bash
# 默认站点配置文件为项目根目录下面的hugo.toml、hugo.yaml、 或hugo.json
hugo --config debugconfig.toml
hugo --config a.toml,b.toml,c.toml


```



## 一、配置文件



### archetypeDir：默认值为archetypes

### assetDir：默认值为assets

### contentDir：默认值为content

### dataDir：默认值为data

### themesDir：默认值为themes















## 一、内容配置



```
+++
title = 'one'
date = 2023-09-21T09:24:52+08:00
draft = true
+++
```



1.  draft：默认true
2.  



```bash
# 覆盖
hugo --buildDrafts    # or -D
hugo --buildExpired   # or -E
hugo --buildFuture    # or -F
```







# 模块



```
提供 Hugo 中定义的 7种组件类型中的一种或多种：static、content、layouts、data、assets、i18n和archetypes。
```



```toml
[module]
  noProxy = 'none'
  noVendor = ''
  private = '*.*'
  proxy = 'direct'
  replacements = ''
  workspace = 'off'
```





```
hugo mod init github.com/gohugoio/myShortcodes
```





### 使用模块作为主题

```toml
[module]
[[module.imports]]
    path = 'github.com/spf13/hyde'
```



# 主题





```toml
theme = ['my-shortcodes', 'base-theme', 'hyde']
```









## docsy

```bash
PS C:\Users\wl\docsy-example> hugo mod graph
github.com/google/docsy-example github.com/google/docsy@v0.7.1
github.com/google/docsy-example github.com/google/docsy/dependencies@v0.7.1
github.com/google/docsy/dependencies@v0.7.1 github.com/twbs/bootstrap@v5.2.3+incompatible
github.com/google/docsy/dependencies@v0.7.1 github.com/FortAwesome/Font-Awesome@v0.0.0-20230327165841-0698449d50f2
PS C:\Users\wl\docsy-example>


```

















