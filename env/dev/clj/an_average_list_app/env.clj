(ns an-average-list-app.env
  (:require
    [selmer.parser :as parser]
    [clojure.tools.logging :as log]
    [an-average-list-app.dev-middleware :refer [wrap-dev]]))

(def defaults
  {:init
   (fn []
     (parser/cache-off!)
     (log/info "\n-=[an_average_list_app started successfully using the development profile]=-"))
   :stop
   (fn []
     (log/info "\n-=[an_average_list_app has shut down successfully]=-"))
   :middleware wrap-dev})
