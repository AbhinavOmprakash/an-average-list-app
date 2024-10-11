(ns an-average-list-app.env
  (:require [clojure.tools.logging :as log]))

(def defaults
  {:init
   (fn []
     (log/info "\n-=[an_average_list_app started successfully]=-"))
   :stop
   (fn []
     (log/info "\n-=[an_average_list_app has shut down successfully]=-"))
   :middleware identity})
