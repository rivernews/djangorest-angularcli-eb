# Angular + Material Design Component

[Angular Hero Tutorial](https://angular.io/tutorial)

[Angular Material Getting Started](https://material.angular.io/guide/getting-started)

[Our Angular Notebook](https://medium.com/p/763e5d938b39/edit)

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

## Adding new view (page) and route to it

[adding a view](https://angular.io/tutorial/toh-pt5#add-the-dashboard-route)

- `ng generate component dashboard`

- in routing ts import the component, then register a routing path for that component

- refine contents in component: edit component's html, configure its ts.

- add link to route to that component, if needed.

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