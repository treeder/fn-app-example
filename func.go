package main

import (
	"fmt"
	"html/template"
	"log"
	"net/url"
	"os"
	"strings"
)

type Link struct {
	Text string
	Href string
}

func main() {
	const tpl = `
	<!DOCTYPE html>
	<html>
		<head>
			<meta charset="UTF-8">
			<title>{{.Title}}</title>
		</head>
		<body>
			<h1>{{.Title}}</h1>
			<p>{{.Body}}</p>
			<div>
				{{range .Items}}<div><a href="{{.Href}}">{{ .Text }}</a></div>{{else}}<div><strong>no rows</strong></div>{{end}}
			</div>
		</body>
	</html>`

	check := func(err error) {
		if err != nil {
			log.Fatal(err)
		}
	}
	t, err := template.New("webpage").Parse(tpl)
	check(err)

	appName := os.Getenv("FN_APP_NAME")
	reqURL := os.Getenv("FN_REQUEST_URL")
	url, err := url.Parse(reqURL)
	if err != nil {
		panic(err)
	}
	pathPrefix := ""
	if strings.HasPrefix(url.Path, "/r/") {
		pathPrefix = fmt.Sprintf("/r/%s", appName)
	}

	data := struct {
		Title string
		Body  string
		Items []Link
	}{
		Title: "My App",
		Body:  "This is my app. It may not be the best app, but it's my app. And it's multilingual!",
		Items: []Link{
			Link{"Ruby", fmt.Sprintf("%s/ruby", pathPrefix)},
			Link{"Node", fmt.Sprintf("%s/node", pathPrefix)},
			Link{"Python", fmt.Sprintf("%s/python", pathPrefix)},
		},
	}

	err = t.Execute(os.Stdout, data)
	check(err)
}
