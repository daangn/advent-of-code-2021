(ns hello_santa
  (:require [clojure.java.io :as io]
            [clojure.string :as s]))

(println "hello! 🎅🎄")

(defn- parse
  [input]
  (->> (s/split-lines input)
       (map #(Integer/parseInt %))))

(def input
  (-> "sample-input.txt"
      io/resource
      slurp
      parse))

(prn (apply + input))