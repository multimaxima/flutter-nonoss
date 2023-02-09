import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

class MapPolygon extends StatefulWidget {
  final LatLng kordinat;
  final List<LatLng> locationList;

  const MapPolygon(this.kordinat, this.locationList, {super.key});

  @override
  State<MapPolygon> createState() => _MapPolygonState();
}

class _MapPolygonState extends State<MapPolygon> {
  final Completer<GoogleMapController> _controller = Completer();

  final Set<Marker> _markers = {};
  final Set<Polygon> _polygon = HashSet<Polygon>();
  MapType tipeMap = MapType.satellite;

  void gantiTipe() {
    if (tipeMap == MapType.normal) {
      setState(() {
        tipeMap = MapType.hybrid;
      });
    } else if (tipeMap == MapType.hybrid) {
      setState(() {
        tipeMap = MapType.satellite;
      });
    } else if (tipeMap == MapType.satellite) {
      setState(() {
        tipeMap = MapType.terrain;
      });
    } else if (tipeMap == MapType.terrain) {
      setState(() {
        tipeMap = MapType.normal;
      });
    }
  }

  void _handleTap(LatLng tappedPoint) {
    setState(() {
      widget.locationList.add(tappedPoint);

      if (widget.locationList.length > 2) {
        _markers.clear();
        _markers.add(
          Marker(
            markerId: MarkerId(widget.kordinat.toString()),
            position: widget.kordinat,
          ),
        );

        _polygon.add(
          Polygon(
            polygonId: const PolygonId("1"),
            points: widget.locationList,
            fillColor: Colors.red.withOpacity(0.3),
            geodesic: true,
            strokeWidth: 4,
            strokeColor: Colors.red,
          ),
        );
      } else {
        _markers.add(
          Marker(
            markerId: MarkerId(tappedPoint.toString()),
            position: tappedPoint,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _markers.add(
      Marker(
        markerId: MarkerId(widget.kordinat.toString()),
        position: widget.kordinat,
      ),
    );

    if (widget.locationList.length > 2) {
      _polygon.add(
        Polygon(
          polygonId: const PolygonId("1"),
          points: widget.locationList,
          fillColor: Colors.red.withOpacity(0.3),
          geodesic: true,
          strokeWidth: 4,
          strokeColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: widget.kordinat,
          zoom: 20,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        polygons: _polygon,
        mapType: tipeMap,
        markers: _markers,
        onTap: _handleTap,
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Material(
            type: MaterialType.transparency,
            child: Ink(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 3.0),
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: InkWell(
                onTap: () => gantiTipe(),
                borderRadius: BorderRadius.circular(1000.0),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.map,
                    size: 30.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Material(
            type: MaterialType.transparency,
            child: Ink(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 3.0),
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    widget.locationList.clear();
                    _polygon.clear();
                  });
                },
                borderRadius: BorderRadius.circular(1000.0),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.delete,
                    size: 30.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Material(
            type: MaterialType.transparency,
            child: Ink(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 3.0),
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: InkWell(
                onTap: () {
                  Get.back(result: widget.locationList);
                },
                borderRadius: BorderRadius.circular(1000.0),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.keyboard_arrow_left,
                    size: 30.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
