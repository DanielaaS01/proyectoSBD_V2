// Datos de ejemplo para obras
        const obras = [
            {
                id: 1,
                nombre: "La Noche Estrellada",
                tipo: "pintura",
                coleccion: "Arte Moderno Europeo",
                periodo: "Post-Impresionismo (1889)",
                dimensiones: "73.7 cm × 92.1 cm",
                ubicacion: "Galería Principal, Sala 3",
                estilos: ["Post-Impresionismo", "Expresionismo"],
                materiales: "Óleo sobre lienzo",
                caracteristicas: "Pinceladas ondulantes, colores vibrantes, cielo nocturno con estrellas en espiral",
                artistas: [
                    { nombre: "Vincent van Gogh", iniciales: "VG", rol: "Autor principal" }
                ],
                adquisicion: {
                    metodo: "Adquirida",
                    fecha: "15 de marzo de 1941"
                },
                museo: 1
            },
            {
                id: 2,
                nombre: "El Pensador",
                tipo: "escultura",
                coleccion: "Esculturas Clásicas",
                periodo: "Arte Moderno (1904)",
                dimensiones: "180 cm × 98 cm × 145 cm",
                ubicacion: "Jardín de Esculturas, Pedestal 5",
                estilos: ["Realismo", "Simbolismo"],
                materiales: "Bronce fundido con pátina",
                caracteristicas: "Figura masculina sentada en posición pensativa, musculatura detallada",
                artistas: [
                    { nombre: "Auguste Rodin", iniciales: "AR", rol: "Escultor" }
                ],
                adquisicion: {
                    metodo: "Donada",
                    fecha: "7 de septiembre de 1973"
                },
                museo: 1
            },
            {
                id: 3,
                nombre: "Guernica",
                tipo: "pintura",
                coleccion: "Arte del Siglo XX",
                periodo: "Cubismo (1937)",
                dimensiones: "349.3 cm × 776.6 cm",
                ubicacion: "Sala de Exposiciones Temporales",
                estilos: ["Cubismo", "Surrealismo"],
                materiales: "Óleo sobre lienzo",
                caracteristicas: "Monocromático en tonos grises, negros y blancos, representa el bombardeo de Guernica",
                artistas: [
                    { nombre: "Pablo Picasso", iniciales: "PP", rol: "Autor principal" }
                ],
                adquisicion: {
                    metodo: "Adquirida",
                    fecha: "24 de junio de 1992"
                },
                museo: 3
            },
            {
                id: 4,
                nombre: "David",
                tipo: "escultura",
                coleccion: "Renacimiento Italiano",
                periodo: "Renacimiento (1501-1504)",
                dimensiones: "517 cm × 199 cm",
                ubicacion: "Galería de Esculturas Clásicas",
                estilos: ["Renacimiento", "Clasicismo"],
                materiales: "Mármol blanco",
                caracteristicas: "Figura masculina de pie, representación del héroe bíblico antes de enfrentarse a Goliat",
                artistas: [
                    { nombre: "Miguel Ángel", iniciales: "MA", rol: "Escultor" }
                ],
                adquisicion: {
                    metodo: "Adquirida",
                    fecha: "12 de agosto de 1882"
                },
                museo: 2
            },
            {
                id: 5,
                nombre: "La Persistencia de la Memoria",
                tipo: "pintura",
                coleccion: "Surrealismo",
                periodo: "Surrealismo (1931)",
                dimensiones: "24 cm × 33 cm",
                ubicacion: "Sala de Arte Moderno, Vitrina 7",
                estilos: ["Surrealismo", "Arte Moderno"],
                materiales: "Óleo sobre lienzo",
                caracteristicas: "Relojes derretidos en un paisaje onírico, colores cálidos y atmósfera desértica",
                artistas: [
                    { nombre: "Salvador Dalí", iniciales: "SD", rol: "Autor principal" }
                ],
                adquisicion: {
                    metodo: "Donada",
                    fecha: "3 de noviembre de 1934"
                },
                museo: 3
            },
            {
                id: 6,
                nombre: "Venus de Milo",
                tipo: "escultura",
                coleccion: "Arte Helenístico",
                periodo: "Helenístico (130-100 a.C.)",
                dimensiones: "202 cm × 80 cm",
                ubicacion: "Sala de Antigüedades, Pedestal 2",
                estilos: ["Helenístico", "Clásico"],
                materiales: "Mármol de Paros",
                caracteristicas: "Figura femenina sin brazos, representa a Afrodita (Venus), diosa del amor",
                artistas: [
                    { nombre: "Alejandro de Antioquía", iniciales: "AA", rol: "Escultor" }
                ],
                adquisicion: {
                    metodo: "Adquirida",
                    fecha: "25 de abril de 1820"
                },
                museo: 4
            },
            {
                id: 7,
                nombre: "La Gioconda (Mona Lisa)",
                tipo: "pintura",
                coleccion: "Renacimiento Italiano",
                periodo: "Alto Renacimiento (1503-1519)",
                dimensiones: "77 cm × 53 cm",
                ubicacion: "Galería Principal, Sala 1 (Alta Seguridad)",
                estilos: ["Renacimiento", "Sfumato"],
                materiales: "Óleo sobre tabla de álamo",
                caracteristicas: "Retrato de medio cuerpo de una mujer con sonrisa enigmática, técnica sfumato",
                artistas: [
                    { nombre: "Leonardo da Vinci", iniciales: "LV", rol: "Autor principal" }
                ],
                adquisicion: {
                    metodo: "Adquirida",
                    fecha: "10 de diciembre de 1797"
                },
                museo: 2
            },
            {
                id: 8,
                nombre: "Los Girasoles",
                tipo: "pintura",
                coleccion: "Post-Impresionismo",
                periodo: "Post-Impresionismo (1888)",
                dimensiones: "92.1 cm × 73 cm",
                ubicacion: "Galería de Arte Moderno, Sala 4",
                estilos: ["Post-Impresionismo", "Naturaleza Muerta"],
                materiales: "Óleo sobre lienzo",
                caracteristicas: "Serie de bodegones con girasoles en un jarrón, predominan los tonos amarillos",
                artistas: [
                    { nombre: "Vincent van Gogh", iniciales: "VG", rol: "Autor principal" }
                ],
                adquisicion: {
                    metodo: "Donada",
                    fecha: "17 de julio de 1924"
                },
                museo: 5
            }
        ];
        
        // Datos de ejemplo para museos
        const museos = [
            {id: 1, nombre: 'Museo Nacional de Arte'},
            {id: 2, nombre: 'Museo de Historia Natural'},
            {id: 3, nombre: 'Museo de Arte Contemporáneo'},
            {id: 4, nombre: 'Museo de Antropología'},
            {id: 5, nombre: 'Museo de Ciencias'}
        ];
        
        // Función para cargar la lista de obras según los filtros
        function cargarObras(filtroMuseo = '', filtroTipo = '') {
            const listaObras = document.getElementById('artworkList');
            listaObras.innerHTML = '';
            
            // Filtrar las obras según los criterios
            let obrasFiltradas = obras;
            
            if (filtroMuseo) {
                obrasFiltradas = obrasFiltradas.filter(obra => obra.museo === parseInt(filtroMuseo));
            }
            
            if (filtroTipo) {
                obrasFiltradas = obrasFiltradas.filter(obra => obra.tipo === filtroTipo);
            }
            
            // Actualizar contador de obras
            document.getElementById('artworkCount').textContent = `Mostrando ${obrasFiltradas.length} obras`;
            
            // Si no hay resultados
            if (obrasFiltradas.length === 0) {
                listaObras.innerHTML = `
                    <div class="no-results">
                        <svg class="no-results-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                            <path d="M15.5 14h-.79l-.28-.27C15.41 12.59 16 11.11 16 9.5 16 5.91 13.09 3 9.5 3S3 5.91 3 9.5 5.91 16 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z"/>
                        </svg>
                        <p>No se encontraron obras con los filtros seleccionados</p>
                    </div>
                `;
                return;
            }
            
            // Crear elementos para cada obra
            obrasFiltradas.forEach(obra => {
                const obraElement = document.createElement('div');
                obraElement.className = 'artwork-item';
                obraElement.dataset.id = obra.id;
                
                // Determinar la clase para el tipo de obra
                const tipoClass = obra.tipo === 'pintura' ? 'type-painting' : 'type-sculpture';
                const tipoTexto = obra.tipo === 'pintura' ? 'Pintura' : 'Escultura';
                
                // Encontrar el nombre del museo
                const museo = museos.find(m => m.id === obra.museo);
                const nombreMuseo = museo ? museo.nombre : 'Museo desconocido';
                
                obraElement.innerHTML = `
                    <div class="artwork-name">${obra.nombre}</div>
                    <div class="artwork-meta">
                        ${nombreMuseo}
                        <span class="artwork-type ${tipoClass}">${tipoTexto}</span>
                    </div>
                `;
                
                // Agregar evento de clic para mostrar detalles
                obraElement.addEventListener('click', () => mostrarDetalleObra(obra.id));
                
                listaObras.appendChild(obraElement);
            });
        }
        
        // Función para mostrar el detalle de una obra
        function mostrarDetalleObra(obraId) {
            // Buscar la obra por ID
            const obra = obras.find(o => o.id === obraId);
            
            if (!obra) {
                mostrarNotificacion('No se encontró la información de la obra', 'error');
                return;
            }
            
            // Marcar como activa en la lista
            const items = document.querySelectorAll('.artwork-item');
            items.forEach(item => {
                if (parseInt(item.dataset.id) === obraId) {
                    item.classList.add('active');
                } else {
                    item.classList.remove('active');
                }
            });
            
            // Ocultar mensaje de "ninguna obra seleccionada"
            document.getElementById('noArtworkSelected').style.display = 'none';
            
            // Mostrar el detalle
            const detalle = document.getElementById('artworkDetail');
            detalle.style.display = 'block';
            
            // Actualizar título
            document.getElementById('detailTitle').textContent = obra.nombre;
            
            // Actualizar información general
            document.getElementById('nombreObra').textContent = obra.nombre;
            document.getElementById('tipoObra').textContent = obra.tipo === 'pintura' ? 'Pintura' : 'Escultura';
            document.getElementById('coleccion').textContent = obra.coleccion;
            document.getElementById('periodo').textContent = obra.periodo;
            document.getElementById('dimensiones').textContent = obra.dimensiones;
            document.getElementById('ubicacion').textContent = obra.ubicacion;
            
            // Actualizar estilos
            const estilosContainer = document.getElementById('estilos');
            estilosContainer.innerHTML = '';
            obra.estilos.forEach(estilo => {
                const tag = document.createElement('span');
                tag.className = 'tag';
                tag.textContent = estilo;
                estilosContainer.appendChild(tag);
            });
            
            // Actualizar materiales y características
            document.getElementById('materiales').textContent = obra.materiales;
            document.getElementById('caracteristicas').textContent = obra.caracteristicas;
            
            // Actualizar artistas
            const artistasContainer = document.getElementById('artistasContainer');
            artistasContainer.innerHTML = '';
            obra.artistas.forEach(artista => {
                const artistaCard = document.createElement('div');
                artistaCard.className = 'artist-card';
                artistaCard.innerHTML = `
                    <div class="artist-avatar">${artista.iniciales}</div>
                    <div class="artist-info">
                        <div class="artist-name">${artista.nombre}</div>
                        <div class="artist-role">${artista.rol}</div>
                    </div>
                `;
                artistasContainer.appendChild(artistaCard);
            });
            
            // Actualizar información de adquisición
            document.getElementById('metodoAdquisicion').textContent = obra.adquisicion.metodo;
            document.getElementById('fechaAdquisicion').textContent = obra.adquisicion.fecha;
            
            const badgeAdquisicion = document.getElementById('badgeAdquisicion');
            if (obra.adquisicion.metodo === 'Adquirida') {
                badgeAdquisicion.className = 'acquisition-badge badge-acquired';
                badgeAdquisicion.textContent = 'Adquirida por el museo';
            } else {
                badgeAdquisicion.className = 'acquisition-badge badge-donated';
                badgeAdquisicion.textContent = 'Donada al museo';
            }
            
            // Actualizar imagen
            const imagePlaceholder = document.getElementById('imagePlaceholder');
            const artworkImage = document.getElementById('artworkImage');
            
            // Por defecto mostrar el placeholder ya que no tenemos imágenes reales
            artworkImage.style.display = 'none';
            imagePlaceholder.style.display = 'flex';
        }
        
        // Función para aplicar filtros
        document.getElementById('aplicarFiltros').addEventListener('click', function() {
            const filtroMuseo = document.getElementById('museoFilter').value;
            const filtroTipo = document.getElementById('tipoObraFilter').value;
            
            cargarObras(filtroMuseo, filtroTipo);
            
            // Mostrar notificación
            mostrarNotificacion('Filtros aplicados correctamente', 'success');
        });
        
        // Función para mostrar notificaciones
        function mostrarNotificacion(mensaje, tipo) {
            const notification = document.getElementById('notification');
            const notificationIcon = document.getElementById('notificationIcon');
            const notificationMessage = document.getElementById('notificationMessage');
            
            // Configurar tipo de notificación
            if (tipo === 'success') {
                notification.className = 'notification notification-success show';
                notificationIcon.innerHTML = '<path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"/>';
            } else {
                notification.className = 'notification notification-error show';
                notificationIcon.innerHTML = '<path d="M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12z"/>';
            }
            
            // Establecer mensaje
            notificationMessage.textContent = mensaje;
            
            // Ocultar después de 3 segundos
            setTimeout(() => {
                notification.className = 'notification';
            }, 3000);
        }
        
        // Cerrar notificación al hacer clic en X
        document.getElementById('notificationClose').addEventListener('click', function() {
            document.getElementById('notification').className = 'notification';
        });
        
        // Botón para cargar imagen
        document.getElementById('uploadImageBtn').addEventListener('click', function() {
            // Simulación de carga de imagen
            const input = document.createElement('input');
            input.type = 'file';
            input.accept = 'image/*';
            
            input.onchange = function(e) {
                const file = e.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function(event) {
                        const artworkImage = document.getElementById('artworkImage');
                        artworkImage.src = event.target.result;
                        artworkImage.style.display = 'block';
                        document.getElementById('imagePlaceholder').style.display = 'none';
                        mostrarNotificacion('Imagen cargada correctamente', 'success');
                    };
                    reader.readAsDataURL(file);
                }
            };
            
            input.click();
        });
        
        // Botón para imprimir reporte
        document.getElementById('printReport').addEventListener('click', function() {
            window.print();
        });
        
        // Botón para exportar a PDF
        document.getElementById('exportPDF').addEventListener('click', function() {
            mostrarNotificacion('Exportación a PDF iniciada', 'success');
            // En una implementación real, aquí iría el código para generar el PDF
        });
        
        // Inicializar la página cargando todas las obras
        document.addEventListener('DOMContentLoaded', function() {
            cargarObras();
            
            // Mostrar animaciones después de cargar
            setTimeout(() => {
                document.querySelector('.filters-section').style.opacity = '1';
                document.querySelector('.artwork-list-container').style.opacity = '1';
                document.querySelector('.artwork-detail-container').style.opacity = '1';
            }, 100);
        });