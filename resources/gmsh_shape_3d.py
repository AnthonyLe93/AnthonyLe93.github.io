#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Sep 12 14:00:00 2021

@author: anthony
"""
import gmsh
import numpy as np
import sys
import os
import math, random
import matplotlib.pyplot as plt

resultPath = os.path.dirname(os.path.abspath(__file__)) + '/'

def createLines(PointTags):
    
    LineTags = np.empty((0,1),dtype=int)    
    NPoints = len(PointTags)
    
    #for i in range(1, NPoints): # Lines for outer circle
        #LineTags = np.append(LineTags, [gmsh.model.occ.addLine(PointTags[i-1], PointTags[i])])
        
        
    LineTags = np.append(LineTags, [gmsh.model.occ.addLine(PointTags[NPoints-2], PointTags[NPoints-1])]) # draw line between the last gap
    
    #print('LineTags: ' + str(LineTags))
    return LineTags  


def createSplines(PointTags):
    SplineTags = np.empty((0,1),dtype=int)    
    NPoints = len(PointTags)
        
    #for i in range(1, NPoints,1): # Lines for outer circle
        #SplineTags = np.append(SplineTags, [gmsh.model.occ.addSpline([PointTags[i-1], PointTags[i]])])
       
    
    SplineTags = np.append(SplineTags, [gmsh.model.occ.addSpline(range(PointTags[0],PointTags[NPoints-1]))])
    
    
    #print('SplineTags: ' + str(SplineTags))    
        
    print('NPoints: ' + str(NPoints))
    return SplineTags  

    
def outterRing(lc = 1, step=1):
    data = np.loadtxt(resultPath + 'n4_a5_xy.txt')
    
    x = data[:,0]
    y = data[:,1]
    
    
    PointTags = np.empty((0,1), int)
    
    #PointTags = np.append(PointTags, [gmsh.model.occ.addPoint(0,0,0, lc)])
    PointTags = np.append(PointTags, [gmsh.model.occ.addPoint(x, y, 10, lc) for (x,y) in zip(x,y)])
    
    
    if step==1:  #importing outter ring coordinates
       gmsh.model.occ.synchronize()
       gmsh.fltk.run()
    
   
    #print('PointTags: ' + str(PointTags))
    
    
    LineTags = createLines(PointTags)
    
    SplineTags = createSplines(PointTags)
    #WireLoop = gmsh.model.occ.addWire(SplineTags)
    WireLoop = gmsh.model.occ.addWire([SplineTags,LineTags])
   
    SurfaceTag = gmsh.model.occ.addPlaneSurface([WireLoop])
    gmsh.model.occ.healShapes()
    outterRingDimtags = SurfaceTag
    
    
    if step==2:  #drawing outter ring
       gmsh.model.occ.synchronize()
       gmsh.fltk.run()
    
       
    return outterRingDimtags 
        
def innerRing(lc = 1, step=1):
    data = np.loadtxt(resultPath + 'n4_a5_xy2.txt')
    x = data[:,0]
    y = data[:,1]
    
    PointTags = np.empty((0,1), int)
    
    #PointTags = np.append(PointTags, [gmsh.model.occ.addPoint(0,0,0, lc)])
    PointTags = np.append(PointTags, [gmsh.model.occ.addPoint(x, y, 10, lc) for (x,y) in zip(x,y)])
    
    if step==3:  #importing inner ring coordinates
       gmsh.model.occ.synchronize()
       gmsh.fltk.run()
    

    LineTags = createLines(PointTags)   
     
    SplineTags = createSplines(PointTags)
    #WireLoop = gmsh.model.occ.addWire(SplineTags)   
    WireLoop = gmsh.model.occ.addWire([SplineTags,LineTags])
      
    SurfaceTag = gmsh.model.occ.addPlaneSurface([WireLoop])
    #gmsh.model.occ.healShapes()
    innerRingDimtags = SurfaceTag
    
    
    if step==4:  #drawing inner ring
       gmsh.model.occ.synchronize()
       gmsh.fltk.run()
    
       
    return innerRingDimtags     

def innerRing2(lc = 1, step=1):
    data = np.loadtxt(resultPath + 'n4_a5_xy2_2.txt')
    x = data[:,0]
    y = data[:,1]
    
    PointTags = np.empty((0,1), int)
    
    #PointTags = np.append(PointTags, [gmsh.model.occ.addPoint(0,0,0, lc)])
    PointTags = np.append(PointTags, [gmsh.model.occ.addPoint(x, y, 10, lc) for (x,y) in zip(x,y)])
    
    if step==3:  #importing inner ring coordinates
       gmsh.model.occ.synchronize()
       gmsh.fltk.run()
    

    LineTags = createLines(PointTags)   
     
    SplineTags = createSplines(PointTags)
    #WireLoop = gmsh.model.occ.addWire(SplineTags)   
    WireLoop = gmsh.model.occ.addWire([SplineTags,LineTags])
      
    SurfaceTag = gmsh.model.occ.addPlaneSurface([WireLoop])
    #gmsh.model.occ.healShapes()
    innerRingDimtags2 = SurfaceTag
    
    
    if step==4:  #drawing inner ring
       gmsh.model.occ.synchronize()
       gmsh.fltk.run()
    
       
    return innerRingDimtags2     

def innerRing3(lc = 1, step=1):
    data = np.loadtxt(resultPath + 'n4_a5_xy2_3.txt')
    x = data[:,0]
    y = data[:,1]
    
    PointTags = np.empty((0,1), int)
    
    #PointTags = np.append(PointTags, [gmsh.model.occ.addPoint(0,0,0, lc)])
    PointTags = np.append(PointTags, [gmsh.model.occ.addPoint(x, y, 10, lc) for (x,y) in zip(x,y)])
    
    if step==3:  #importing inner ring coordinates
       gmsh.model.occ.synchronize()
       gmsh.fltk.run()
    

    LineTags = createLines(PointTags)   
     
    SplineTags = createSplines(PointTags)
    #WireLoop = gmsh.model.occ.addWire(SplineTags)   
    WireLoop = gmsh.model.occ.addWire([SplineTags,LineTags])
      
    SurfaceTag = gmsh.model.occ.addPlaneSurface([WireLoop])
    #gmsh.model.occ.healShapes()
    innerRingDimtags3 = SurfaceTag
    
    
    if step==4:  #drawing inner ring
       gmsh.model.occ.synchronize()
       gmsh.fltk.run()
    
       
    return innerRingDimtags3   
    
    
def innerRing4(lc = 1, step=1):
    data = np.loadtxt(resultPath + 'n4_a5_xy2_4.txt')
    x = data[:,0]
    y = data[:,1]
    
    PointTags = np.empty((0,1), int)
    
    #PointTags = np.append(PointTags, [gmsh.model.occ.addPoint(0,0,0, lc)])
    PointTags = np.append(PointTags, [gmsh.model.occ.addPoint(x, y, 10, lc) for (x,y) in zip(x,y)])
    
    if step==3:  #importing inner ring coordinates
       gmsh.model.occ.synchronize()
       gmsh.fltk.run()
    

    LineTags = createLines(PointTags)   
     
    SplineTags = createSplines(PointTags)
    #WireLoop = gmsh.model.occ.addWire(SplineTags)   
    WireLoop = gmsh.model.occ.addWire([SplineTags,LineTags])
      
    SurfaceTag = gmsh.model.occ.addPlaneSurface([WireLoop])
    #gmsh.model.occ.healShapes()
    innerRingDimtags4 = SurfaceTag
    
    
    if step==4:  #drawing inner ring
       gmsh.model.occ.synchronize()
       gmsh.fltk.run()
    
       
    return innerRingDimtags4         

def generateGeometry(step):
    gmsh.initialize()
    gmsh.option.setNumber("General.Terminal", 1)
    
    gmsh.model.add("Accordion")
    gmsh.logger.start()    
    
    wallThickness = 3
    
    outterCurve = outterRing(lc=3, step=step)
    innerCurve = innerRing(lc=3, step=step)
    innerCurve2 = innerRing2(lc=3, step=step)
    innerCurve3 = innerRing3(lc=3, step=step)  
    innerCurve4 = innerRing4(lc=3, step=step) 
    

    
    if step == 5: #drawing outer ring and inner ring
       gmsh.model.occ.synchronize()
       gmsh.fltk.run()
    
    CutOut = gmsh.model.occ.cut([(2,outterCurve)],[(2,innerCurve),(2,innerCurve2),(2,innerCurve3),(2,innerCurve4)])
    print("CutOut",CutOut)
    RingDimTags = CutOut[0]
    
    
    ExtrudeHeight = 70
    gmsh.model.occ.extrude(RingDimTags,0,0,ExtrudeHeight)    
    
    if step == 6: #extruding the geometry
       gmsh.model.occ.synchronize()
       gmsh.fltk.run()
    
         
    gmsh.option.setNumber("Mesh.CharacteristicLengthFactor", 0.3)
    
    gmsh.model.mesh.generate(2)
    gmsh.model.occ.synchronize()
    gmsh.write('mesh/n4_a5.stl')
    gmsh.model.mesh.clear()

    gmsh.option.setNumber("Mesh.CharacteristicLengthFactor", 0.3)    
    gmsh.model.mesh.generate(3)    
    gmsh.model.occ.synchronize()
    gmsh.write('mesh/n4_a5.vtk')  
    
    gmsh.option.setNumber("Mesh.CharacteristicLengthFactor", 0.3)    
    gmsh.model.mesh.generate(3)    
    gmsh.model.occ.synchronize()
    gmsh.write('mesh/n4_a5.step')    

    if step == 0 or step ==7: # saving all the mesh files
       gmsh.model.occ.synchronize()
       gmsh.fltk.run()
       
    
step=0
print("Showing Step: " + str(step))
generateGeometry(step)
    
