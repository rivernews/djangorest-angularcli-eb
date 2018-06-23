# Angular

This project was generated with [Angular CLI](https://github.com/angular/angular-cli) version 6.0.1.

## Development server

Run `ng serve` for a dev server. Navigate to `http://localhost:4200/`. The app will automatically reload if you change any of the source files.

## Code scaffolding

Run `ng generate component component-name` to generate a new component. You can also use `ng generate directive|pipe|service|class|guard|interface|enum|module`.

## Build

Run `ng build` to build the project. The build artifacts will be stored in the `dist/` directory. Use the `--prod` flag for a production build.

## Further help

To get more help on the Angular CLI use `ng help` or go check out the [Angular CLI README](https://github.com/angular/angular-cli/blob/master/README.md).

# Angular + Material Design Component

- [Angular Hero Tutorial](https://angular.io/tutorial)

- [Angular Material Getting Started](https://material.angular.io/guide/getting-started)

- [Our Angular Notebook](https://medium.com/p/763e5d938b39/edit)

- Additional NPM Packages Required Besides Angular CLI
```
@angular/material @angular/cdk @angular/animations
font-awesome
```
Use `npm i -D <packages>` to install.

## Adding Angular Routing Function

[add routing module](https://angular.io/tutorial/toh-pt5#add-the-approutingmodule)

- `ng generate module app-routing --module=app`
  - in `app-routing.module.ts ` you can delete the `commonModule` and `declarations` stuff.

- in `app-routing.module.ts`

```
...
import { RouterModule, Routes } from '@angular/router';

// import components
import { HeroesComponent } from './heroes/heroes.component';

const routes: Routes = [
  { path: '', redirectTo: '/dashboard', pathMatch: 'full' },
  { path: 'dashboard', component: DashboardComponent },
  { path: 'heroes', component: HeroesComponent },
  { path: 'detail/:id', component: HeroDetailComponent }, // routing w/ a parameter
];

@NgModule({
  imports: [ RouterModule.forRoot(routes) ], // configure the router at the application's root level
  exports: [ RouterModule ],
})
export class AppRoutingModule { }
```

- add `<router-outlet></router-outlet>` in `app.component.html`

- whenever you want to route through a link, you can now do 

```
<a routerLink="/heroes">Heroes</a>
```

## Adding Service

In Angular 6 `ng g s services/user`, by default it is provided as Singleton Services and already setup the provider for you. See [this post](https://stackoverflow.com/questions/42748773/angular-cli-generate-a-service-and-include-the-provider-in-one-step)


## Adding new view (page) and route to it

[adding a view](https://angular.io/tutorial/toh-pt5#add-the-dashboard-route)

- `ng generate component dashboard`

- in routing ts import the component, then register a routing path for that component

- refine contents in component: edit component's html, configure its ts.

- add link to route to that component, if needed.

## Making POST request to backend

- If you're using elastic beanstalk, make sure you turn on the WSGI Authorization on. [See this post](https://stackoverflow.com/questions/22279301/authorization-credentials-stripped-django-elastic-beanstalk-oauth). If you don't do this, EB will strip off your authorization header and you always get 401 unauthorized.

## Using Angular Material Design Components

See our [Angular Notebook on Medium](https://medium.com/p/763e5d938b39/edit) for basic setup.

- the suggested default app-root html is

```
<mat-sidenav-container fullscreen>
  <mat-toolbar color="primary">
    <mat-toolbar-row>
      <h2 class="mat-h2">{{title}}</h2>
      <a mat-raised-button routerLink="/link_to_page_1">Page 1</a>
    </mat-toolbar-row>
  </mat-toolbar>
  <router-outlet></router-outlet>
  <footer></footer>
</mat-sidenav-container>
```

### Styling

- [Use SCSS as angular's default styling sheet](https://stackoverflow.com/questions/46760306/get-material-2-theme-color-scheme-palette-for-other-elements)
you might want to run `ng config schematics.@schematics/angular:component.styleext scss` for latest Angular.

#### How to use Material's theme to components?

#### [Use Awesome font in mat-icon](https://theinfogrid.com/tech/developers/angular/material-icons-angular-5/)

- Install awesome font, if you haven't.
- add `"node_modules/font-awesome/scss/font-awesome.scss",` in `angular-cli.json`. Add to the `styles` list under `build`.
- Make sure you imported `MatIconModule` in angular root ts.
- Import material's icon service in angular root module ts, or wherever module you import material components:
```
import { MatIconRegistry } from "@angular/material";
```
  - we'll have to register Awesome Font in the module as well:

```
export class GoogleMaterialDesignModule {
  constructor(
    public matIconRegistry: MatIconRegistry,
  ){
    matIconRegistry.registerFontClassAlias('fontawesome', 'fa');

    // avoid typing fontSet="fa"
    this.matIconRegistry.setDefaultFontSetClass('fa');
  }
}

```
- Now, you can use icons by doing the following:
```
<mat-icon fontIcon="fa-home"></mat-icon>
```

- If you need more icon, however, it will require Awesome Font 5 and needs additional settings.

#### [Set Awesome font to default in mat-icon](https://stackoverflow.com/questions/43837076/how-to-correctly-register-font-awesome-for-md-icon)

# Reference

- How to update Angular and Angular CLI. [Angular CLI Official Git](https://github.com/angular/angular-cli)
  - You might have to udpate for both global and local.