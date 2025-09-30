import { Component } from '@angular/core';
import { Storage } from '@ionic/storage-angular';
import { COMPANIA } from './app.config';
import { IconsService } from './servicios/icons.service';

@Component({
  selector: 'app-root',
  templateUrl: 'app.component.html',
  styleUrls: ['app.component.scss'],
})
export class AppComponent {
  compania = COMPANIA;
  
  constructor(
    private storage: Storage,
    private iconsService: IconsService
  ) {
    // Los íconos se registran automáticamente al inyectar el servicio
  }

  async ngOnInit() {
    await this.storage.create();
  }
}

