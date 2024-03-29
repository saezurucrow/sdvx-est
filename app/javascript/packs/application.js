// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require jquery3
//= require popper
//= require bootstrap

//= require rails-ujs
//= require activestorage
//= require turbolinks

import Rails from '@rails/ujs';
import Turbolinks from 'turbolinks';
import * as ActiveStorage from '@rails/activestorage';
import 'channels';

import 'bootstrap';
import 'bootstrap-icons/font/bootstrap-icons.css';
import 'jquery';
import '../src/application.scss';

Rails.start();
Turbolinks.start();
ActiveStorage.start();
