# Angular + Material Design Component

[Angular Hero Tutorial](https://angular.io/tutorial)
[Angular Material Getting Started](https://material.angular.io/guide/getting-started)

## Adding Angular Routing Function

[add routing module](https://angular.io/tutorial/toh-pt5#add-the-approutingmodule)

1. `ng generate module app-routing --module=app`
  - in `app-routing.module.ts ` you can delete the `commonModule` and `declarations` stuff.

1. in `app-routing.module.ts`

```
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

1. add `<router-outlet></router-outlet>` in `app.component.html`

1. whenever you want to route through a link, you can now do 

```
<a routerLink="/heroes">Heroes</a>
``

## Adding new view (page) and route to it