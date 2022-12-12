import { HttpClient } from "@angular/common/http";
import {Component} from "@angular/core"
import { Product, productList } from "src/interface/home.interface";

@Component({

    selector: 'home',
    templateUrl: './home.component.html'

})

export class HomeComponent{
    dropIndicatorvalue2: boolean = true;
    displayIndicatorvalue2: boolean = true;

    product? : Product[];
    count: number = 20;

    constructor( private http: HttpClient ){

    }

    click(){

        this.count += 20

        this.ngOnInit()

    }

    unclick(){

        this.count -= 20

        this.ngOnInit()

        while( this.count < 0){
            alert("Something went wrong")
            this.count += 20
        }
    }

    ngOnInit(){

        let url = 'https://dummyjson.com/products?limit='+this.count+''
        this.http.get<{products:Product[]}>(url).subscribe( data => {
            this.product = data.products
            console.log(this.product)
        })

    }

}