(ns an-average-list-app.app
  (:require [an-average-list-app.core :as core]))

;;ignore println statements in prod
(set! *print-fn* (fn [& _]))

(core/init!)
