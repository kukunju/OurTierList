// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"

import "channels"

import 'jquery';
import 'jquery-ui/ui/widgets/draggable';
import 'jquery-ui/ui/widgets/droppable';

import "@nathanvda/cocoon";

import "popper.js";
import "bootstrap";

import "../stylesheets/application";
import "../stylesheets/tier_list";

const images = require.context("../images", true);
const imagePath = name => images(name, true);

Rails.start()
Turbolinks.start()
ActiveStorage.start()

//= require jquery
//= require jquery_ujs
//= require cocoon
