package main

import (
  "github.com/gorilla/mux"
  "log"
  "mlambda.net/sample/pkg/api"
  "net/http"
)

func main()  {
  router := mux.NewRouter().StrictSlash(true)
  router.HandleFunc("/", api.HomeHandler)
  log.Fatal(http.ListenAndServe(":8080", router))
}
